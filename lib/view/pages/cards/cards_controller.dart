import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class CardsController extends UBaseController {
  late URxn<PanInfo> selectedCard = URxn<PanInfo>(Core.currentFile.value.panInfoList.firstOrNull);
  final URxBool balanceHidden = false.obs;
  final URxBool autoPlay = false.obs;
  final URxn<TransactionResponse> transactionResponse = URxn<TransactionResponse>();

  final TextEditingController giftPanController = TextEditingController();
  final TextEditingController giftExpiryController = TextEditingController();
  final TextEditingController giftCvvController = TextEditingController();
  // final TextEditingController giftPinController = TextEditingController();

  List<PanInfo> get cards => Core.currentFile.value.panInfoList;

  PanInfo get giftCardPreview => PanInfo(
    panId: "",
    pan: giftPanController.numString(),
    panType: "ANONYMOUS",
    cvv2: giftCvvController.text.isEmpty ? null : giftCvvController.numString(),
    expiredDate: giftExpiryController.numString(),
    tokenizePanInfo: null,
  );

  Future<void> selectProfile(FileInfo profile) async {
    _applyProfile(profile);
  }

  void selectCard(PanInfo card) => selectedCard(card);

  void toggleBalance() => balanceHidden.toggle();

  void toggleAutoPlay() => autoPlay.toggle();

  void clearGiftCardForm() {
    giftPanController.clear();
    giftExpiryController.clear();
    giftCvvController.clear();
    // giftPinController.clear();
  }

  void registerGiftCard() => UValidators.validateForm(
    key: formKey,
    action: () {
      ULoading.show();
      Core.dataSource.registerAnonymousCard(
        page: U.s.cards,
        p: RegisterCardParams(
          fileId: Core.currentFile.value.fileId,
          pan: giftPanController.numString(),
          expiryDate: giftExpiryController.numString(),
          cvv2: giftCvvController.numString(),
          // pin: giftPinController.numString(),
        ),
        onOk: _reloadCards,
        onError: (ErrorResponse response) {
          ULoading.dismiss();
          UToast.errorToast(message: response.errorMessage);
        },
        onException: (String response) {
          ULoading.dismiss();
        },
      );
    },
  );

  Future<void> _reloadCards() async {
    await Core.dataSource.getFileInfo(
      page: U.s.cards,
      onOk: (GetFileInfoResponse response) {
        final String fileId = Core.currentFile.value.fileId;
        Core.fileInfo(response);
        Core.currentFile(response.fileInfoList.where((FileInfo e) => e.fileId == fileId).firstOrNull ?? response.fileInfoList.first);
        final String? selectedPanId = selectedCard.value?.panId;
        selectedCard(cards.where((PanInfo e) => e.panId == selectedPanId).firstOrNull ?? cards.firstOrNull);
      },
      onError: (ErrorResponse response) => UToast.errorToast(message: response.errorMessage),
      onException: null,
    );
    ULoading.dismiss();
    UNavigator.back();
    UToast.success(message: "کارت هدیه با موفقیت ثبت شد");
  }

  void _applyProfile(FileInfo? profile) {
    final List<PanInfo> list = profile?.panInfoList ?? <PanInfo>[];
    selectedCard(list.isEmpty ? null : list.first);
  }
}
