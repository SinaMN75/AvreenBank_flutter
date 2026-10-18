import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

enum TransactionFilter { all, credit, debit }

class HomeController extends UBaseController {
  final URxBool balanceHidden = false.obs;
  final URxn<GetFileInfoResponse> fileInfoResponse = URxn<GetFileInfoResponse>();
  final URxn<TransactionResponse> transactionResponse = URxn<TransactionResponse>();

  List<AccountInfo> get accounts => Core.currentFile.value.accountInfoList;

  int get totalBalance => accounts.fold<int>(0, (int sum, AccountInfo account) => sum + (account.availableBalance ?? 0));

  void toggleBalance() => balanceHidden.toggle();

  Future<void> refreshFileInfo() async {
    await Core.dataSource.getFileInfo(
      page: U.s.home,
      onOk: (GetFileInfoResponse response) {
        final String fileId = Core.currentFile.value.fileId;
        Core.fileInfo(response);
        Core.currentFile(response.fileInfoList.where((FileInfo e) => e.fileId == fileId).firstOrNull ?? response.fileInfoList.first);
      },
      onError: (ErrorResponse response) => UToast.errorToast(message: response.errorMessage),
      onException: null,
    );
  }
}
