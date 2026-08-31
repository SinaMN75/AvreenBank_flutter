import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

enum TransactionFilter { all, credit, debit }

class HomeController extends UBaseController {
  final Rxn<FileInfo> activeProfile = Rxn<FileInfo>();
  final RxBool balanceHidden = false.obs;
  final Rx<TransactionFilter> filter = TransactionFilter.all.obs;
  final Rxn<GetFileInfoResponse> fileInfoResponse = Rxn<GetFileInfoResponse>();
  final Rxn<TransactionResponse> transactionResponse = Rxn<TransactionResponse>();

  List<AccountInfo> get accounts => activeProfile.value?.accountInfoList ?? <AccountInfo>[];

  int get totalBalance => accounts.fold<int>(0, (int sum, AccountInfo account) => sum + (account.availableBalance ?? 0));

  List<TransactionInfo> get visibleTransactions {
    final List<TransactionInfo> all = transactionResponse.value?.transactionInfoList ?? <TransactionInfo>[];
    switch (filter.value) {
      case TransactionFilter.all:
        return all;
      case TransactionFilter.credit:
        return all.where((TransactionInfo tx) => (tx.debitType ?? 0) == 0).toList();
      case TransactionFilter.debit:
        return all.where((TransactionInfo tx) => (tx.debitType ?? 0) != 0).toList();
    }
  }

  void init() {
    activeProfile(Core.currentFile.value);
  }

  // Future<void> _loadTransactions() async {
  //   state.loading();
  //   final FileInfo? profile = activeProfile.value;
  //   if (profile == null) return;
  //
  //   await Core.dataSource.viewTransaction(
  //     p: TransactionParams(fileId: profile.fileId),
  //     onOk: (TransactionResponse response) {
  //       transactionResponse(response);
  //       state.loaded();
  //     },
  //     onError: (ErrorResponse e) {
  //       UToast.errorToast(message: e.errorMessage);
  //       state.error();
  //     },
  //     onException: (String e) {
  //       UToast.errorToast(message: e);
  //       state.error();
  //     },
  //   );
  // }

  Future<void> selectProfile(FileInfo profile) async {
    activeProfile(profile);
    filter(TransactionFilter.all);
  }

  void toggleBalance() => balanceHidden.toggle();

  void setFilter(TransactionFilter value) {
    filter(value);
  }
}
