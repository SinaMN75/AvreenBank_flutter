import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class CardsController extends UBaseController {
  final RxList<FileInfo> profiles = RxList<FileInfo>();
  final Rxn<FileInfo> activeProfile = Rxn<FileInfo>();
  late Rxn<PanInfo> selectedCard = Rxn<PanInfo>(Core.currentFile.value.panInfoList.first);
  final RxBool balanceHidden = false.obs;
  final RxBool autoPlay = false.obs;
  final Rxn<TransactionResponse> transactionResponse = Rxn<TransactionResponse>();

  List<PanInfo> get cards => activeProfile.value?.panInfoList ?? <PanInfo>[];

  void init() {
    activeProfile(Core.currentFile.value);
  }

  Future<void> selectProfile(FileInfo profile) async {
    _applyProfile(profile);
  }

  void selectCard(PanInfo card) => selectedCard(card);

  void toggleBalance() => balanceHidden.toggle();

  void toggleAutoPlay() => autoPlay.toggle();

  void _applyProfile(FileInfo? profile) {
    activeProfile(profile);
    final List<PanInfo> list = profile?.panInfoList ?? <PanInfo>[];
    selectedCard(list.isEmpty ? null : list.first);
  }
}
