import "package:avreen_bank/data/home_api.dart";
import "package:avreen_bank/model/card_model.dart";
import "package:avreen_bank/model/profile_model.dart";
import "package:u/utilities.dart";

class CardsController extends UBaseController {
  final HomeApi _api = const HomeApi();

  final RxList<ProfileModel> profiles = RxList<ProfileModel>();
  final Rxn<ProfileModel> activeProfile = Rxn<ProfileModel>();
  final Rxn<CardModel> selectedCard = Rxn<CardModel>();
  final RxBool balanceHidden = false.obs;
  final RxSet<String> blockedCardIds = <String>{}.obs;

  List<CardModel> get cards => activeProfile.value?.cards ?? <CardModel>[];

  bool isBlocked(CardModel card) => blockedCardIds.contains(card.id);

  CardStatus statusOf(CardModel card) => isBlocked(card) ? CardStatus.blocked : card.status;

  Future<void> fetchData() async {
    state.loading();
    final List<ProfileModel> result = await _api.getProfiles();
    profiles.assignAll(result);
    _applyProfile(result.isEmpty ? null : result.first);
    state.loaded();
  }

  void selectProfile(ProfileModel profile) => _applyProfile(profile);

  void selectCard(CardModel card) => selectedCard(card);

  void toggleBalance() => balanceHidden.toggle();

  void toggleBlock(CardModel card) => isBlocked(card) ? blockedCardIds.remove(card.id) : blockedCardIds.add(card.id);

  void _applyProfile(ProfileModel? profile) {
    activeProfile(profile);
    final List<CardModel> list = profile?.cards ?? <CardModel>[];
    selectedCard(list.isEmpty ? null : list.first);
  }
}
