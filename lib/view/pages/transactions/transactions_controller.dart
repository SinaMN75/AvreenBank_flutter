import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

enum TransactionDatePreset {
  today("امروز", 0, 0),
  yesterday("دیروز", 1, 1),
  last3Days("۳ روز گذشته", 2, 0);

  const TransactionDatePreset(this.title, this.fromDaysAgo, this.toDaysAgo);

  final String title;
  final int fromDaysAgo;
  final int toDaysAgo;
}

class TransactionsController {
  final GlobalKey<FormState> byCountKey = GlobalKey<FormState>();
  final URx<UJalali> startDate = UJalali.now().firstDayOfMonth().obs;
  final URx<UJalali> endDate = UJalali.now().obs;
  final TextEditingController controllerCount = TextEditingController(text: "10");
  final URxList<TransactionInfo> byCountList = <TransactionInfo>[].obs;
  final URxList<TransactionInfo> byDateList = <TransactionInfo>[].obs;
  final URxState byCountState = URxState();
  final URxState byDateState = URxState();
  final URxn<TransactionDatePreset> datePreset = URxn<TransactionDatePreset>();

  void init() {
    selectDatePreset(TransactionDatePreset.today);
  }

  void selectDatePreset(TransactionDatePreset preset) {
    final UJalali now = UJalali.now();
    datePreset(preset);
    startDate(now.addDays(-preset.fromDaysAgo));
    endDate(now.addDays(-preset.toDaysAgo));
  }

  Future<void> pickStartDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: startDate.value, lastDate: endDate.value);
    if (date == null) return;
    datePreset(null);
    startDate(date);
  }

  Future<void> pickEndDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: endDate.value, firstDate: startDate.value, lastDate: UJalali.now());
    if (date == null) return;
    datePreset(null);
    endDate(date);
  }

  void getTransactionsByCount() => UValidators.validateForm(
    key: byCountKey,
    action: () => _fetch(
      p: TransactionParams(fileId: Core.currentFile.value.fileId, count: controllerCount.text.toInt()),
      list: byCountList,
      state: byCountState,
    ),
  );

  void getTransactionsByDate() => _fetch(
    p: TransactionParams(
      fileId: Core.currentFile.value.fileId,
      startDateTime: _startOfDay(startDate.value).toString(),
      endDateTime: _startOfDay(endDate.value).add(const Duration(days: 1)).toString(),
    ),
    list: byDateList,
    state: byDateState,
  );

  DateTime _startOfDay(UJalali date) => date.toDateTime().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  void _fetch({required TransactionParams p, required URxList<TransactionInfo> list, required URxState state}) {
    state.loading();
    Core.dataSource.viewTransaction(
      p: p,
      onOk: (TransactionResponse response) {
        list(response.transactionInfoList);
        if (list.isEmpty)
          state.emptying();
        else
          state.loaded();
      },
      onError: (ErrorResponse e) {
        state.error();
        UToast.errorToast(message: e.errorMessage);
      },
      onException: (String e) {
        state.error();
        UToast.errorToast(message: e);
      },
    );
  }
}
