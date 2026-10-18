import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class StatusFaceController extends UBaseController {
  late AccountInfo accountInfo;
  final URxn<FileInfo> activeProfile = URxn<FileInfo>();
  List<CreditStatement> list = <CreditStatement>[];
  
  void init({required AccountInfo accountInfo}) {
    this.accountInfo = accountInfo;
    read();
  }

  void read() {
    state.loading();
    Core.dataSource.creditStatement(
      page: U.s.statement,
      p: CreditStatementParams(accountId: accountInfo.accountId),
      onOk: (CreditStatementResponse response) {
        list = response.result;
        if (response.result.isEmpty) state.emptying();
        else state.loaded();
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

  void readLoanDetails({required String? billId, required Function(List<StatementLoanDetail> list) onOk}) {
    ULoading.show();
    Core.dataSource.statementLoanDetails(
      page: U.s.statement,
      p: StatementLoanDetailsParams(billId: billId),
      onOk: (StatementLoanDetailsResponse response) {
        ULoading.dismiss();
        onOk(response.result);
      },
      onError: (ErrorResponse response) {
        ULoading.dismiss();
        UToast.errorToast(message: response.errorMessage);
      },
      onException: (String response) {
        ULoading.dismiss();
      },
    );
  }

  void readCreditDetails({required String? billId, required Function(List<StatementCreditDetail> list) onOk}) {
    ULoading.show();
    Core.dataSource.statementCreditDetails(
      page: U.s.statement,
      p: StatementCreditDetailsParams(billId: billId),
      onOk: (StatementCreditDetailsResponse response) {
        ULoading.dismiss();
        onOk(response.result);
      },
      onError: (ErrorResponse response) {
        ULoading.dismiss();
        UToast.errorToast(message: response.errorMessage);
      },
      onException: (String response) {
        ULoading.dismiss();
      },
    );
  }
}
