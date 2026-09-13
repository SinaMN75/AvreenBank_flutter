import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

enum TransactionFilter { all, credit, debit }

class HomeController extends UBaseController {
  final RxBool balanceHidden = false.obs;
  final Rxn<GetFileInfoResponse> fileInfoResponse = Rxn<GetFileInfoResponse>();
  final Rxn<TransactionResponse> transactionResponse = Rxn<TransactionResponse>();

  List<AccountInfo> get accounts => Core.currentFile.value.accountInfoList;

  int get totalBalance => accounts.fold<int>(0, (int sum, AccountInfo account) => sum + (account.availableBalance ?? 0));

  void toggleBalance() => balanceHidden.toggle();
}
