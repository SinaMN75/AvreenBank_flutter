import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class TransactionsController extends UBaseController {
  List<TransactionInfo> transactions = <TransactionInfo>[];

  Future<void> init() async {
    state.loading();
    final FileInfo profile = Core.currentFile.value;
    await Core.dataSource.viewTransaction(
      p: TransactionParams(fileId: profile.fileId),
      onOk: (TransactionResponse response) {
        transactions = response.transactionInfoList;
        if (transactions.isEmpty)
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
