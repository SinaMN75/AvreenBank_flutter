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
        UToast.errorToast(message: response);
        state.error();
      },
    );
  }
}
