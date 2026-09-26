import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class StatementController {
  late AccountInfo selectedAccount;
  final GlobalKey<FormState> byCountKey = GlobalKey<FormState>();
  final URx<UJalali> startDate = UJalali(1400).obs;
  final URx<UJalali> endDate = UJalali.now().obs;
  final TextEditingController controllerCount = TextEditingController(text: "10");
  final URxList<StatementElement> byCountList = <StatementElement>[].obs;
  final URxList<StatementElement> byDateList = <StatementElement>[].obs;
  final URxState state = URxState();

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
    action: () {
      state.loading();
      Core.dataSource.accountStatement(
        p: AccountStatementParams(
          accountId: selectedAccount.accountId!,
          count: controllerCount.text.toInt(),
          startDateTime: DateTime(2020).toString(),
          endDateTime: DateTime(2030).toString(),
        ),
        onOk: (AccountStatementResponse response) {
          byCountList(response.statementElementList);
          if (byCountList.isEmpty)
            state.emptying();
          else
            state.loaded();
        },
        onError: (ErrorResponse response) {
          state.error();
          UToast.error(message: response.errorMessage);
        },
        onException: (String response) {
          state.error();
          UToast.error(message: response);
        },
      );
    },
  );

  void getTransactionsByDate() {
    state.loading();
    Core.dataSource.accountStatement(
      p: AccountStatementParams(
        accountId: selectedAccount.accountId!,
        count: 10,
        startDateTime: startDate.value.toDateTime().toString(),
        endDateTime: endDate.value.toDateTime().add(const Duration(days: 1)).toString(),
      ),
      onOk: (AccountStatementResponse response) {
        byDateList(response.statementElementList);
        if (byDateList.isEmpty)
          state.emptying();
        else
          state.loaded();
      },
      onError: (ErrorResponse response) {
        state.error();
        UToast.error(message: response.errorMessage);
      },
      onException: (String response) {
        state.error();
        UToast.error(message: response);
      },
    );
  }
}
