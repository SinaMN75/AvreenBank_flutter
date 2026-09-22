import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class CardsController extends UBaseController {
  late URxn<PanInfo> selectedCard = URxn<PanInfo>(Core.currentFile.value.panInfoList.first);
  final URxBool balanceHidden = false.obs;
  final URxBool autoPlay = false.obs;
  final URxn<TransactionResponse> transactionResponse = URxn<TransactionResponse>();

  List<PanInfo> get cards => Core.currentFile.value.panInfoList;

  Future<void> selectProfile(FileInfo profile) async {
    _applyProfile(profile);
  }

  void selectCard(PanInfo card) => selectedCard(card);

  void toggleBalance() => balanceHidden.toggle();

  void toggleAutoPlay() => autoPlay.toggle();

  void _applyProfile(FileInfo? profile) {
    final List<PanInfo> list = profile?.panInfoList ?? <PanInfo>[];
    selectedCard(list.isEmpty ? null : list.first);
  }
}
