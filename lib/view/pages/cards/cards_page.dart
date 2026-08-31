import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/cards/cards_controller.dart";
import "package:avreen_bank/view/pages/transactions/transactions_page.dart";
import "package:avreen_bank/view/widgets/bank_card_view.dart";
import "package:avreen_bank/view/widgets/dynamic_pin_sheet.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:avreen_bank/view/widgets/profile_sheet.dart";
import "package:u/utilities.dart";

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends UState<CardsPage> {
  final CardsController c = CardsController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Obx(() {
      if (c.state.isLoading()) return const Center(child: UProgressCircular());
      final List<PanInfo> cards = c.cards;
      return SingleChildScrollView(
        child: UColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ProfileSelectorTile(
              badge: c.activeProfile.value?.fileTitle ?? "",
              name: c.activeProfile.value?.fileTitle ?? "",
              color: context.colorScheme.primary,
              onTap: () => _openProfileSheet(context),
            ).pSymmetric(vertical: 8, horizontal: 16),
            if (cards.isEmpty)
              UEmptyState(title: U.s.noCardsInThisProfile)
            else ...<Widget>[
              _carousel(cards).pSymmetric(vertical: 8),
              _cardDetail(context).pSymmetric(vertical: 8, horizontal: 16),
            ],
          ],
        ),
      );
    }),
  );

  Widget _carousel(List<PanInfo> cards) => UCarousel<PanInfo>(
    key: ValueKey<String?>(c.activeProfile.value?.fileId),
    items: cards,
    viewportFraction: 0.86,
    itemSpacing: 12,
    withIndicator: true,
    onPageChanged: (PanInfo card, int index) => c.selectCard(card),
    itemBuilder: (BuildContext context, PanInfo card, int index) => Obx(
      () => BankCardView(card, selected: card.panId == c.selectedCard.value?.panId).ltr(),
    ),
  );

  Widget _cardDetail(BuildContext context) => Obx(() => UCard(
      color: scheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UTextTitleMedium(c.selectedCard.value?.pan ?? "---", fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          UTextLabelSmall("${U.s.expires}: ${c.selectedCard.value?.expiredDate ?? "**/**"}", color: scheme.onSurfaceVariant),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              UButton(title: U.s.dynamicPin, onTap: _openPinSheet, foregroundColor: scheme.onPrimary, expanded: 1),
              const SizedBox(width: 8),
              UButton(
                title: U.s.getPinBySms,
                type: UButtonType.outlined,
                onTap: () => UToast.success(message: U.s.pinSentBySms),
                expanded: 1,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              UButton(
                title: U.s.blockCardTemp,
                type: UButtonType.outlined,
                foregroundColor: AppColors.danger,
                borderColor: AppColors.danger,
                onTap: () {},
                expanded: 1,
              ),
              const SizedBox(width: 8),
              UButton(
                title: U.s.transactions,
                type: UButtonType.outlined,
                onTap: () => UNavigator.push(const TransactionsPage()),
                expanded: 1,
              ),
            ],
          ),
        ],
      ).pAll(16),
    ));

  void _openPinSheet() => UNavigator.bottomSheet<void>(const DynamicPinSheet());

  void _openProfileSheet(BuildContext context) => UNavigator.bottomSheet<void>(
    ProfileSheet(
      profiles: c.profiles,
      activeId: c.activeProfile.value?.fileId,
      onSelect: (FileInfo profile) {
        c.selectProfile(profile);
        UNavigator.back();
      },
    ),
  );
}
