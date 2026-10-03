import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class TransactionsController {
  final GlobalKey<FormState> byCountKey = GlobalKey<FormState>();
  final URx<UJalali> startDate = UJalali.now().firstDayOfMonth().obs;
  final URx<UJalali> endDate = UJalali.now().obs;
  final TextEditingController controllerCount = TextEditingController(text: "10");
  final URxList<TransactionInfo> byCountList = <TransactionInfo>[].obs;
  final URxList<TransactionInfo> byDateList = <TransactionInfo>[].obs;
  final URxList<TransactionInfo> todayList = <TransactionInfo>[].obs;
  final URxState byCountState = URxState();
  final URxState byDateState = URxState();
  final URxState todayState = URxState();

  void init() {
    getTransactionsToday();
  }

  Future<void> pickStartDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: startDate.value, lastDate: endDate.value);
    if (date != null) startDate(date);
  }

  Future<void> pickEndDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: endDate.value, firstDate: startDate.value, lastDate: UJalali.now());
    if (date != null) endDate(date);
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
      startDateTime: startDate.value.toDateTime().toString(),
      endDateTime: endDate.value.toDateTime().add(const Duration(days: 1)).toString(),
    ),
    list: byDateList,
    state: byDateState,
  );

  void getTransactionsToday() => _fetch(
    p: TransactionParams(
      fileId: Core.currentFile.value.fileId,
      startDateTime: DateTime.now().copyWith(hour: 0, minute: 0, second: 0).toString(),
      endDateTime: DateTime.now().copyWith(hour: 23, minute: 59, second: 59).toString(),
    ),
    list: todayList,
    state: todayState,
  );

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
