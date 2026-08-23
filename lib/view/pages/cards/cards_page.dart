import "package:avreen_bank/main.dart";
import "package:avreen_bank/model/card_model.dart";
import "package:avreen_bank/model/profile_model.dart";
import "package:avreen_bank/model/transaction_model.dart";
import "package:avreen_bank/view/pages/cards/cards_controller.dart";
import "package:avreen_bank/view/widgets/bank_card_view.dart";
import "package:avreen_bank/view/widgets/dynamic_pin_sheet.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:avreen_bank/view/widgets/profile_sheet.dart";
import "package:avreen_bank/view/widgets/transaction_tile.dart";
import "package:u/utilities.dart";

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final CardsController c = CardsController();

  @override
  void initState() {
    c.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Obx(() {
      if (c.state.isLoading()) return const Center(child: UProgressCircular());
      return SingleChildScrollView(
        child: UColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: <Widget>[
            ProfileSelectorTile(
              badge: c.activeProfile.value?.badge ?? "",
              name: c.activeProfile.value?.name ?? "",
              color: context.colorScheme.primary,
              onTap: () => _openProfileSheet(context),
            ),
            const SizedBox(height: 14),
            if (c.cards.isEmpty)
              UEmptyState(title: U.s.noCardsInThisProfile)
            else ...<Widget>[
              _carousel(),
              const SizedBox(height: 16),
              _cardDetail(context),
              const SizedBox(height: 20),
              _cardTransactions(context),
            ],
          ],
        ),
      );
    }),
  );

  Widget _carousel() {
    final CardModel? selected = c.selectedCard.value;
    return USlider(
      images: c.cards
          .map(
            (CardModel i) => BankCardView(
              i,
              selected: i.id == selected?.id,
              balanceHidden: c.balanceHidden.value,
              statusLabel: _statusLabel(c.statusOf(i)),
              onTap: () => c.selectCard(i),
            ),
          )
          .toList(),
    );
  }

  Widget _cardDetail(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final CardModel? card = c.selectedCard.value;
    if (card == null) return const SizedBox();
    final bool blocked = c.isBlocked(card);
    return UContainer(
      color: scheme.surface,
      radius: 20,
      border: Border.all(color: scheme.outlineVariant),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UTextTitleMedium(card.title, fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          UTextLabelSmall("${U.s.connectedAccount}: ${card.connectedAccount}", color: scheme.onSurfaceVariant),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              UButton(title: U.s.showPinInApp, onTap: _openPinSheet).expanded(),
              const SizedBox(width: 8),
              UButton(
                title: U.s.getPinBySms,
                type: UButtonType.outlined,
                onTap: () => UToast.success(message: U.s.pinSentBySms),
              ).expanded(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              UButton(
                title: blocked ? U.s.unblockCard : U.s.blockCardTemp,
                type: UButtonType.outlined,
                foregroundColor: blocked ? scheme.primary : AppColors.danger,
                borderColor: blocked ? scheme.primary : AppColors.danger,
                onTap: () => c.toggleBlock(card),
              ).expanded(),
              const SizedBox(width: 8),
              UButton(
                title: U.s.cardLimitsAndSettings,
                type: UButtonType.outlined,
                onTap: () => UToast.info(message: U.s.comingSoon),
              ).expanded(),
            ],
          ),
          const SizedBox(height: 12),
          UTextLabelSmall(U.s.dynamicPinHint, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _cardTransactions(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final List<TransactionModel> items = c.selectedCard.value?.transactions ?? <TransactionModel>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        UKeyValue(leading: UTextTitleMedium(U.s.cardTransactions), trailing: const SizedBox()),
        const SizedBox(height: 10),
        if (items.isEmpty)
          UEmptyState(title: U.s.noTransactions)
        else
          UContainer(
            clipBehavior: Clip.hardEdge,
            color: scheme.surface,
            radius: 18,
            border: Border.all(color: scheme.outlineVariant),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext _, int index) => TransactionTile(items[index], showDivider: index != items.length - 1),
              separatorBuilder: (BuildContext _, int _) => const Divider(),
              itemCount: items.length,
            ),
          ),
      ],
    );
  }

  String _statusLabel(CardStatus status) {
    switch (status) {
      case CardStatus.active:
        return U.s.cardActive;
      case CardStatus.expiringSoon:
        return U.s.cardExpiringSoon;
      case CardStatus.blocked:
        return U.s.cardBlocked;
    }
  }

  void _openPinSheet() => UNavigator.bottomSheet<void>(const DynamicPinSheet());

  void _openProfileSheet(BuildContext context) => UNavigator.bottomSheet<void>(
    ProfileSheet(
      profiles: c.profiles,
      activeId: c.activeProfile.value?.id,
      onSelect: (ProfileModel profile) {
        c.selectProfile(profile);
        UNavigator.back();
      },
    ),
  );
}
