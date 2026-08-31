import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class StatementController {
  late AccountInfo selectedAccount;
  final GlobalKey<FormState> byCountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> byDateKey = GlobalKey<FormState>();
  final Rx<Jalali> startDate = Jalali(1400).obs;
  final Rx<Jalali> endDate = Jalali.now().obs;
  final TextEditingController controllerCount = TextEditingController(text: "10");
  final TextEditingController controllerStartDate = TextEditingController(text: Jalali(1400).formatCompactDate());
  final TextEditingController controllerEndDate = TextEditingController(text: Jalali.now().formatCompactDate());
  final RxList<StatementElement> byCountList = <StatementElement>[].obs;
  final RxList<StatementElement> byDateList = <StatementElement>[].obs;
  final RxState state = RxState();

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
        onError: (ErrorResponse response) => UToast.error(message: response.errorMessage),
        onException: (String response) {},
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
        if (byCountList.isEmpty)
          state.emptying();
        else
          state.loaded();
      },
      onError: (ErrorResponse response) => UToast.error(message: response.errorMessage),
      onException: (String response) {},
    );
  }
}
