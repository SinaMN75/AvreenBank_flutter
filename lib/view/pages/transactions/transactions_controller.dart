import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/u_admin/u_admin.dart";
import "package:u/utils/u_toast.dart";

class TransactionsController extends UBaseController {
  List<TransactionInfo> transactions = <TransactionInfo>[];

  Future<void> init() async {
    state.loading();
    final FileInfo profile = Core.currentFile.value;
    await Core.dataSource.viewTransaction(
      p: TransactionParams(fileId: profile.fileId),
      onOk: (TransactionResponse response) {
        transactions = response.transactionInfoList;
        if (state.isEmpty())
          state.emptying();
        else
          state.loaded();
      },
      onError: (ErrorResponse e) {
        UToast.errorToast(message: e.errorMessage);
        state.error();
      },
      onException: (String e) {
        UToast.errorToast(message: e);
        state.error();
      },
    );
  }
}
