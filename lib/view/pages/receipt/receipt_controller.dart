import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class ReceiptController extends UBaseController {
  late TransactionInfo info;
  TransactionDetailResponse? detail;

  void init({required TransactionInfo info}) {
    this.info = info;
    read();
  }

  void read() {
    state.loading();
    Core.dataSource.viewTransactionDetail(
      page: U.s.transactionReceipt,
      p: TransactionDetailParams(fileId: Core.currentFile.value.fileId, logId: info.logId ?? ""),
      onOk: (TransactionDetailResponse response) {
        detail = response;
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
