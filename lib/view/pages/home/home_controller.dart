import "package:avreen_bank/data/home_api.dart";
import "package:avreen_bank/model/account_model.dart";
import "package:avreen_bank/model/profile_model.dart";
import "package:avreen_bank/model/transaction_model.dart";
import "package:u/utilities.dart";

enum TransactionFilter { all, credit, debit }

class HomeController extends UBaseController {
  final HomeApi _api = const HomeApi();

  final RxList<ProfileModel> profiles = RxList<ProfileModel>();
  final Rxn<ProfileModel> activeProfile = Rxn<ProfileModel>();
  final RxBool balanceHidden = false.obs;
  final Rx<TransactionFilter> filter = TransactionFilter.all.obs;

  List<AccountModel> get accounts => activeProfile.value?.accounts ?? <AccountModel>[];

  int get totalBalance => activeProfile.value?.totalBalance ?? 0;

  List<TransactionModel> get visibleTransactions {
    final List<TransactionModel> all = activeProfile.value?.transactions ?? <TransactionModel>[];
    switch (filter.value) {
      case TransactionFilter.all:
        return all;
      case TransactionFilter.credit:
        return all.where((TransactionModel transaction) => transaction.direction == TransactionDirection.credit).toList();
      case TransactionFilter.debit:
        return all.where((TransactionModel transaction) => transaction.direction == TransactionDirection.debit).toList();
    }
  }

  Future<void> fetchData() async {
    state.loading();
    final List<ProfileModel> result = await _api.getProfiles();
    profiles.assignAll(result);
    activeProfile(result.isEmpty ? null : result.first);
    state.loaded();
  }

  void selectProfile(ProfileModel profile) {
    activeProfile(profile);
    filter(TransactionFilter.all);
  }

  void toggleBalance() => balanceHidden.toggle();

  void setFilter(TransactionFilter value) => filter(value);
}
