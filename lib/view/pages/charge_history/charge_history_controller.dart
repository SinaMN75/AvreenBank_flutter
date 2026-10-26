import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class ChargeHistoryController extends UBaseController {
  late AccountInfo accountInfo;
  final URx<UJalali> fromDate = (UJalali.now().addDays(-365)).firstDayOfMonth().obs;
  final URx<UJalali> toDate = UJalali.now().obs;
  final URx<bool> ascending = false.obs;
  URxList<CreditChargeLog> list = <CreditChargeLog>[].obs;

  void init({required AccountInfo accountInfo}) {
    this.accountInfo = accountInfo;
    read();
  }

  Future<void> pickStartDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: fromDate.value, lastDate: toDate.value);
    if (date != null) fromDate(date);
  }

  Future<void> pickEndDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: toDate.value, firstDate: fromDate.value, lastDate: UJalali.now());
    if (date != null) toDate(date);
  }

  void changeOrder(bool? value) {
    list(list.reversed.toList());
  }

  DateTime _startOfDay(UJalali date) => date.toDateTime().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  Future<void> read() async {
    state.loading();
    await Core.dataSource.creditChargeHistory(
      page: U.s.chargeReport,
      p: CreditChargeHistoryParams(
        accountId: accountInfo.accountId!,
        startDate: _startOfDay(fromDate.value).toString(),
        endDate: _startOfDay(toDate.value).add(const Duration(days: 1)).toString(),
      ),
      onOk: (CreditChargeHistoryResponse response) {
        list(response.result);
        if (list.isEmpty)
          state.emptying();
        else
          state.loaded();
      },
      onError: (ErrorResponse response) {
        UToast.errorToast(message: response.errorMessage);
        state.error();
      },
      onException: (String response) {
        state.error();
      },
    );
  }
}
