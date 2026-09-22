import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/cards/cards_controller.dart";
import "package:avreen_bank/view/pages/transactions/transactions_page.dart";
import "package:avreen_bank/view/widgets/bank_card_view.dart";
import "package:avreen_bank/view/widgets/profile_selector_header.dart";
import "package:flutter/cupertino.dart";
import "package:u/utilities.dart";

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends UState<CardsPage> {
  final CardsController c = CardsController();

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: UObx(() {
      if (c.state.isLoading()) return const Center(child: UProgressCircular());
      final List<PanInfo> cards = c.cards;
      return SingleChildScrollView(
        child: UColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ProfileSelectorHeader(onProfileChanged: () {}),
            if (cards.isEmpty)
              UEmptyState(title: U.s.noCardIssuedForThisProfile).pOnly(top: height / 2.8)
            else ...<Widget>[
              _carousel(cards).pSymmetric(vertical: 8),
              _cardDetail(context),
            ],
          ],
        ),
      );
    }),
  );

  Widget _carousel(List<PanInfo> cards) => UCarousel<PanInfo>(
    key: ValueKey<String?>(Core.currentFile.value.fileId),
    items: cards,
    viewportFraction: 0.86,
    itemSpacing: 12,
    withIndicator: true,
    onPageChanged: (PanInfo card, int index) => c.selectCard(card),
    itemBuilder: (BuildContext context, PanInfo card, int index) => UObx(
      () => BankCardView(card, selected: card.panId == c.selectedCard.value?.panId).ltr(),
    ),
  );

  Widget _cardDetail(BuildContext context) => UObx(
    () => UCard(
      color: scheme.surface,
      child: UColumn(
        margin: const EdgeInsets.all(16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UContainer(
                expanded: 1,
                radius: 16,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.5)),
                color: scheme.primary.withValues(alpha: 0.05),
                onPress: () => UNavigator.bottomSheet(
                    UColumn(
                      mainAxisSize: MainAxisSize.min,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      children: <Widget>[
                        UListTile(
                          icon: Icons.credit_card,
                          title: U.s.cardNumber,
                          subtitle: (c.selectedCard.value?.pan ?? "---").separateCharacters(4, " "),
                          trailingIcon: Icons.copy,
                          onTap: () => UClipboard.set(c.selectedCard.value?.pan ?? "---", snackBar: true),
                        ),
                      ],
                    ),
                  ),
                child: UIconTextVertical(
                  leading: UIconBackground(
                    Icons.ios_share_outlined,
                    color: scheme.primary,
                    backgroundColor: scheme.surface,
                  ),
                  trailing: UTextBodyMedium(U.s.cardDetails, color: scheme.primary),
                ),
              ),
              UContainer(
                expanded: 1,
                radius: 16,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.5)),
                color: scheme.primary.withValues(alpha: 0.05),
                child: UIconTextVertical(
                  leading: UIconBackground(
                    Icons.pin_outlined,
                    color: scheme.primary,
                    backgroundColor: scheme.surface,
                  ),
                  trailing: UTextBodyMedium(U.s.dynamicPin, color: scheme.primary),
                ),
                onPress: () => UToast.snackBar(message: U.s.comingSoon),
              ),
            ],
          ),
          UTextBodyLarge(U.s.settings, margin: const EdgeInsets.symmetric(vertical: 16)),
          _listTile(
            title: U.s.transactions,
            subtitle: "آخرین تراکنش‌های کارت",
            leading: const UIconBackground(Icons.bookmark, color: Colors.orange),
            onTap: () => UNavigator.push(const TransactionsPage()),
          ),
          _listTile(
            title: "پرداخت با QR",
            subtitle: "نمایش بارکد برای پرداخت فروشگاهی",
            leading: const UIconBackground(Icons.credit_card, color: Colors.purple),
            onTap: cardQrSheet,
          ),
          _listTile(
            title: U.s.temporarilyBlock,
            subtitle: "کارت حکمت خود را موقتا غیر فعال کنید.",
            leading: const UIconBackground(Icons.star, color: Colors.blue),
            trailing: CupertinoSwitch(value: false, onChanged: (bool i) => UToast.snackBar(message: U.s.comingSoon)),
            onTap: null,
          ),
        ],
      ),
    ),
  );

  void cardQrSheet() {
    if (c.selectedCard.value?.tokenizePanInfo?.track2 == null) {
      UToast.snackBar(message: U.s.errorReadingData);
    } else {
      UNavigator.bottomSheet(
        UColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: <Widget>[
            UKeyValue(
              leading: const Text("پرداخت با QR"),
              trailing: UButton(title: U.s.close, type: UButtonType.text, onTap: UNavigator.back),
            ),
            const UBarcode(
              value: "c.selectedCard.value!.tokenizePanInfo!.track2!",
              barColor: Colors.black,
              width: 200,
              height: 200,
            ),
            Text((c.selectedCard.value?.pan ?? "").separateCharacters(4, "  ")).ltr(),
            const UTextLabelSmall("بارکد را روبه‌روی دوربین مارتخوان بگیرید", textAlign: TextAlign.center),
          ],
        ),
        showDragHandle: true,
      );
    }
  }

  Widget _listTile({
    required String title,
    required String subtitle,
    required Widget? leading,
    required VoidCallback? onTap,
    Widget? trailing,
  }) => UContainer(
    margin: const EdgeInsets.symmetric(vertical: 8),
    border: Border.all(color: scheme.primary.withValues(alpha: 0.4)),
    color: scheme.primary.withValues(alpha: 0.04),
    borderRadius: BorderRadius.circular(16),
    child: ListTile(
      splashColor: Colors.transparent,
      leading: leading,
      title: Text(title),
      subtitle: UTextLabelSmall(subtitle),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    ),
  );
}
