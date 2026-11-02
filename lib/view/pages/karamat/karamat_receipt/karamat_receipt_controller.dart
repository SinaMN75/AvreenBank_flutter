import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class KaramatReceiptController extends UBaseController {
  late GoodGroupTransaction transaction;
  TransactionDetailResponse? detail;

  void init({required GoodGroupTransaction transaction}) {
    this.transaction = transaction;
    read();
  }

  void read() {
    state.loading();
    Core.dataSource.viewTransactionDetail(
      page: U.s.transactionReceipt,
      p: TransactionDetailParams(fileId: Core.currentFile.value.fileId, logId: transaction.transactionId ?? ""),
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
