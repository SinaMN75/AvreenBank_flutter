import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class CardsController extends UBaseController {
  final RxList<FileInfo> profiles = RxList<FileInfo>();
  final Rxn<FileInfo> activeProfile = Rxn<FileInfo>();
  final Rxn<PanInfo> selectedCard = Rxn<PanInfo>();
  final RxBool balanceHidden = false.obs;
  final RxBool autoPlay = false.obs;
  final RxSet<String> blockedCardIds = <String>{}.obs;
  final Rxn<TransactionResponse> transactionResponse = Rxn<TransactionResponse>();

  List<PanInfo> get cards => activeProfile.value?.panInfoList ?? <PanInfo>[];

  bool isBlocked(PanInfo card) => blockedCardIds.contains(card.panId);

  void init() {
    activeProfile(Core.currentFile.value);
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final FileInfo? profile = activeProfile.value;
    if (profile == null) return;
    await Core.dataSource.viewTransaction(
      p: TransactionParams(fileId: profile.fileId),
      onOk: (TransactionResponse response) {
        transactionResponse(response);
      },
      onError: (ErrorResponse e) {
        UToast.errorToast(message: e.errorMessage);
      },
      onException: (String e) {
        UToast.errorToast(message: e);
      },
    );
  }

  Future<void> selectProfile(FileInfo profile) async {
    _applyProfile(profile);
    await _loadTransactions();
  }

  void selectCard(PanInfo card) => selectedCard(card);

  void toggleBalance() => balanceHidden.toggle();

  void toggleAutoPlay() => autoPlay.toggle();

  void toggleBlock(PanInfo card) => isBlocked(card) ? blockedCardIds.remove(card.panId) : blockedCardIds.add(card.panId);

  void _applyProfile(FileInfo? profile) {
    activeProfile(profile);
    final List<PanInfo> list = profile?.panInfoList ?? <PanInfo>[];
    selectedCard(list.isEmpty ? null : list.first);
  }
}
