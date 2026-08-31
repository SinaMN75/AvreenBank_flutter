import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class StatementController {
  final GlobalKey<FormState> byCountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> byDateKey = GlobalKey<FormState>();
  final Rx<Jalali> startDate = Jalali(1400).obs;
  final Rx<Jalali> endDate = Jalali.now().obs;
  final TextEditingController controllerCount = TextEditingController(text: "10");
  final TextEditingController controllerStartDate = TextEditingController(text: Jalali(1400).formatCompactDate());
  final TextEditingController controllerEndDate = TextEditingController(text: Jalali.now().formatCompactDate());
  final RxList<StatementElement> byCountList = <StatementElement>[].obs;
  final RxList<StatementElement> byDateList = <StatementElement>[].obs;
  final RxState pageState = RxState();
  final RxState byCountState = RxState();
  final RxState byDateState = RxState();
  final RxState byChartState = RxState();
  late RxString selectedAccount;
  late List<AccountInfo> accountInfoList;
  final RxList<FunctionCodeList> functionList = <FunctionCodeList>[].obs;
  final RxList<SubFunctionCodeList> subFunctionList = <SubFunctionCodeList>[].obs;
  final RxnString? selectedFunctionCode = RxnString("---");
  final RxnString? selectedSubFunctionCode = RxnString("---");
  final RxList<AccountStatementResponse> chartDataStatement = <AccountStatementResponse>[].obs;

  void getAccounts() {
    pageState.loading();
    accountInfoList = Core.currentFile.value.accountInfoList;
    selectedAccount = (Core.currentFile.value.accountInfoList.first.accountId ?? "").obs;
    getAccountFunctionCodes();
  }

  void getAccountFunctionCodes() {
    // ULoading.show();
    selectedFunctionCode?.call(null);
    selectedSubFunctionCode?.call(null);
    functionList.clear();
    subFunctionList.clear();
    Core.dataSource.getAccountFunctionCodes(
      p: GetAccountFunctionCodesParams(accountId: selectedAccount.value),
      onOk: (GetAccountFunctionCodesResponse response) {
        selectedFunctionCode?.call("---");
        selectedSubFunctionCode?.call("---");
        functionList(response.functionCodeList!.toList());
        if ((response.functionCodeList?.first.subFunctionCodeList ?? <SubFunctionCodeList>[]).isEmpty) {
          subFunctionList.clear();
          selectedSubFunctionCode?.call(null);
        } else {
          subFunctionList(response.functionCodeList!.first.subFunctionCodeList!.toList());
        }
        pageState.loaded();
      },
      onError: (ErrorResponse response) => UToast.error(message: response.errorMessage),
      onException: (String response) {},
    );
  }

  void getTransactionsByCount() => UValidators.validateForm(
    key: byCountKey,
    action: () {
      byCountState.loading();
      Core.dataSource.accountStatement(
        p: AccountStatementParams(
          functionCode: selectedFunctionCode?.value == "---" ? null : selectedFunctionCode?.value,
          subFunctionCode: selectedSubFunctionCode?.value == "---" ? null : selectedSubFunctionCode?.value,
          accountId: selectedAccount.value,
          count: controllerCount.text.toInt(),
          startDateTime: DateTime(2020).toString(),
          endDateTime: DateTime(2030).toString(),
        ),
        onOk: (AccountStatementResponse response) {
          byCountList(response.statementElementList);
          byCountState.loaded();
        },
        onError: (ErrorResponse response) => UToast.error(message: response.errorMessage),
        onException: (String response) {},
      );
    },
  );

  void getTransactionsByDate() {
    byDateState.loading();
    Core.dataSource.accountStatement(
      p: AccountStatementParams(
        accountId: selectedAccount.value,
        functionCode: selectedFunctionCode?.value == "---" ? null : selectedFunctionCode?.value,
        subFunctionCode: selectedSubFunctionCode?.value == "---" ? null : selectedSubFunctionCode?.value,
        count: 10,
        startDateTime: startDate.value.toDateTime().toString(),
        endDateTime: endDate.value.toDateTime().add(const Duration(days: 1)).toString(),
      ),
      onOk: (AccountStatementResponse response) {
        byDateList(response.statementElementList);
        byDateState.loaded();
      },
      onError: (ErrorResponse response) => UToast.error(message: response.errorMessage),
      onException: (String response) {},
    );
  }
}
