import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/cards/cards_controller.dart";
import "package:avreen_bank/view/pages/nfc/nfc_page.dart";
import "package:avreen_bank/view/pages/transactions/transactions_page.dart";
import "package:avreen_bank/view/widgets/app_sheet.dart";
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
    body: UObx(
      () {
        if (c.state.isLoading()) return const Center(child: UProgressCircular());
        final List<PanInfo> cards = c.cards;
        if (cards.isEmpty)
          return Column(
            children: <Widget>[
              ProfileSelectorHeader(onProfileChanged: () {}),
              const Spacer(),
              UEmptyState(
                title: U.s.noCardIssuedForThisProfile,
                action: UButton(title: "افزودن کارت هدیه", height: 48, elevation: 0, borderRadius: 16, onTap: _giftCardSheet),
              ).alignAtCenter(),
              const Spacer(),
            ],
          );
        final Color tint = scheme.primary.withValues(alpha: 0.12);
        return SingleChildScrollView(
          child: UColumn(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[scheme.primary.withValues(alpha: 0.18), tint]),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProfileSelectorHeader(onProfileChanged: () {}),
              _carousel(cards),
              ColoredBox(
                color: tint,
                child: UContainer(
                  color: scheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: _cardDetail(),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  Widget _carousel(List<PanInfo> cards) => UCarousel<PanInfo>(
    key: ValueKey<String?>(Core.currentFile.value.fileId),
    items: cards,
    height: 216,
    viewportFraction: 0.92,
    itemSpacing: 12,
    withIndicator: cards.length > 1,
    onPageChanged: (PanInfo card, int index) => c.selectCard(card),
    itemBuilder: (BuildContext context, PanInfo card, int index) => UObx(
      () => BankCardView(
        card,
        selected: card.panId == c.selectedCard.value?.panId,
        colors: card.isGift ? AppColors.gradient : AppColors.card,
        label: card.isGift ? "کارت هدیه" : "کارت اعتباری",
      ).pSymmetric(vertical: 8),
    ),
  );

  Widget _cardDetail() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        spacing: 12,
        children: <Widget>[
          _actionTile(icon: Icons.ios_share_rounded, title: "شماره کارت و شبا", onTap: _cardInfoSheet),
          _actionTile(
            icon: Icons.vpn_key_outlined,
            title: U.s.dynamicPin,
            onTap: () => UToast.toast(message: U.s.comingSoon),
          ),
          // _actionTile(icon: Icons.card_giftcard_rounded, title: "افزودن کارت هدیه", onTap: _giftCardSheet),
        ],
      ),
      UTextTitleMedium(U.s.settings, fontWeight: FontWeight.bold, margin: const EdgeInsets.only(top: 28, bottom: 14)),
      Column(
        spacing: 12,
        children: <Widget>[
          _settingTile(
            icon: Icons.bookmark_border_rounded,
            color: AppColors.orange,
            title: "تراکنش‌های کارت",
            subtitle: "آخرین خریدها و گردش کارت",
            onTap: () => UNavigator.push(TransactionsPage(card: c.selectedCard.value)),
          ),
          _settingTile(
            icon: Icons.credit_card_outlined,
            color: AppColors.purple,
            title: "پرداخت با QR",
            subtitle: "نمایش بارکد پرداخت فروشگاهی",
            onTap: _cardQrSheet,
          ),
          _settingTile(
            icon: Icons.credit_card_outlined,
            color: AppColors.purple,
            title: "پرداخت با NFC",
            subtitle: "پرداخت با کارت دیجیتال",
            onTap: () {
              if (c.selectedCard.value?.tokenizePanInfo?.track2 == null) {
                UToast.errorToast(message: U.s.errorReadingData);
                return;
              }
              if (UApp.isAndroid)
                UNavigator.push(NfcPage(valueToSend: c.selectedCard.value!.tokenizePanInfo!.track2!));
              else
                UToast.errorToast(message: "پرداخت با NFC فقط در نسخه نصبی اندروید امکان پذیر است");
            },
          ),
          _settingTile(
            icon: Icons.add_card_outlined,
            color: AppColors.sky,
            title: "درخواست صدور کارت المثنی",
            subtitle: "در صورت مفقودی کارت کارت المثنی درخواست دهید",
            trailing: CupertinoSwitch(value: false, onChanged: (bool _) => _blockSheet()).ltr(),
            onTap: () => UToast.toast(message: U.s.comingSoon),
          ),
          _settingTile(
            icon: Icons.block_rounded,
            color: scheme.error,
            titleColor: scheme.error,
            title: "غیر فعال کردن",
            subtitle: "مسدودسازی در صورت مفقودی یا سرقت",
            onTap: () => UToast.toast(message: U.s.comingSoon),
          ),
        ],
      ),
    ],
  );

  Widget _actionTile({required IconData icon, required String title, required VoidCallback onTap}) => UContainer(
    expanded: 1,
    radius: 20,
    color: scheme.primary.withValues(alpha: 0.06),
    border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    onTap: onTap,
    child: Column(
      spacing: 12,
      children: <Widget>[
        UContainer(
          width: 48,
          height: 48,
          radius: 14,
          alignment: Alignment.center,
          color: scheme.surface,
          child: Icon(icon, color: scheme.primary, size: 22),
        ),
        UTextBodyMedium(
          title,
          color: Color.lerp(scheme.primary, scheme.onSurface, 0.3),
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          fit: BoxFit.scaleDown,
        ),
      ],
    ),
  );

  Widget _settingTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? titleColor,
    Widget? trailing,
  }) => UContainer(
    radius: 20,
    color: scheme.onSurface.withValues(alpha: 0.02),
    border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.7)),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    onTap: onTap,
    child: Row(
      spacing: 14,
      children: <Widget>[
        UIconBackground(icon, color: color, size: 44, radius: 22, backgroundColor: color.withValues(alpha: 0.12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: <Widget>[
              UTextBodyLarge(title, color: titleColor, fontWeight: FontWeight.bold),
              UTextBodySmall(subtitle, color: scheme.onSurfaceVariant, maxLines: 2),
            ],
          ),
        ),
        trailing ?? Icon(Icons.arrow_forward_ios_rounded, size: 16, color: scheme.onSurface),
      ],
    ),
  );

  void _cardInfoSheet() {
    final PanInfo? card = c.selectedCard.value;
    if (card == null) return;
    final String pan = card.pan.separateCharacters(4, " ");
    AppSheet.show<void>(
      title: "شماره کارت و شبا",
      scrollable: false,
      children: <Widget>[
        SheetInfoBox(label: U.s.cardNumber, value: pan, ltr: true, onTap: () => UClipboard.set(card.pan, snackBar: true)),
        SheetInfoBox(label: "دارنده", value: "${Core.fileInfo.value.firstName ?? ""} ${Core.fileInfo.value.lastName ?? ""}"),
        SheetInfoBox(label: "${U.s.expires} / CVV2", value: "${card.expiry() ?? "**/**"} — ${card.cvv2 ?? "***"}".toPersianNumber(), ltr: true),
      ],
    );
  }

  void _cardQrSheet() {
    final PanInfo? card = c.selectedCard.value;
    final String? track2 = card?.tokenizePanInfo?.track2;
    if (card == null || track2 == null) {
      UToast.errorToast(message: U.s.errorReadingData);
      return;
    }
    AppSheet.show<void>(
      title: "پرداخت با QR",
      children: <Widget>[
        UContainer(
          radius: 22,
          color: scheme.onSurface.withValues(alpha: 0.04),
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 14,
            children: <Widget>[
              UBarcode(value: track2, barColor: AppColors.qr, backgroundColor: AppColors.onGradient, width: 200, height: 200),
              UTextTitleLarge(card.pan.separateCharacters(4, " "), fontWeight: FontWeight.bold, textDirection: TextDirection.ltr),
              UTextBodySmall("بارکد را روبه‌روی دوربین کارتخوان بگیرید", color: scheme.onSurfaceVariant, textAlign: TextAlign.center, maxLines: 2),
            ],
          ),
        ),
      ],
    );
  }

  void _giftCardSheet() {
    c.clearGiftCardForm();
    AppSheet.show<void>(
      title: "افزودن کارت هدیه",
      children: <Widget>[
        ListenableBuilder(
          listenable: Listenable.merge(<Listenable>[c.giftPanController, c.giftExpiryController, c.giftCvvController]),
          builder: (BuildContext context, Widget? child) => BankCardView(c.giftCardPreview, selected: true, height: 190, colors: AppColors.gradient, label: "کارت هدیه"),
        ),
        Form(
          key: c.formKey,
          child: Column(
            spacing: 12,
            children: <Widget>[
              UTextField(
                controller: c.giftPanController,
                labelText: U.s.cardNumber,
                hintText: "XXXX XXXX XXXX XXXX",
                validator: UValidators.cardNumber(),
                keyboardType: TextInputType.number,
                formatters: <TextInputFormatter>[UGroupedDigitsInputFormatter(groups: <int>[4, 4, 4, 4])],
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              Row(
                spacing: 12,
                children: <Widget>[
                  UTextField(
                    expanded: 1,
                    controller: c.giftExpiryController,
                    labelText: U.s.expires,
                    hintText: "YY/MM",
                    validator: UValidators.iranianCardExpiry(),
                    keyboardType: TextInputType.number,
                    formatters: <TextInputFormatter>[UGroupedDigitsInputFormatter(groups: <int>[2, 2], separator: "/")],
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  UTextField(
                    expanded: 1,
                    controller: c.giftCvvController,
                    labelText: "CVV2",
                    hintText: "XXX",
                    validator: UValidators.number(minLength: 3, maxLength: 4),
                    keyboardType: TextInputType.number,
                    formatters: <TextInputFormatter>[UNumberInputFormatter(maxDigits: 4)],
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ],
              ),
              // UTextField(
              //   controller: c.giftPinController,
              //   labelText: "رمز کارت",
              //   obscureText: true,
              //   validator: UValidators.required(),
              //   keyboardType: TextInputType.number,
              //   formatters: <TextInputFormatter>[UNumberInputFormatter(maxDigits: 12)],
              //   floatingLabelBehavior: FloatingLabelBehavior.always,
              // ),
            ],
          ),
        ),
        UButton(
          title: U.s.submit,
          height: 54,
          elevation: 0,
          borderRadius: 16,
          fullWidth: true,
          onTap: c.registerGiftCard,
        ),
      ],
    );
  }

  void _blockSheet() => AppSheet.show<void>(
    title: U.s.temporarilyBlock,
    children: <Widget>[
      UTextBodyMedium("موجودی حساب‌ها سر جایش می‌ماند؛ فقط خرید با این کارت متوقف می‌شود.", color: scheme.onSurfaceVariant, maxLines: 3),
      UButton(
        title: "مسدود کردن کارت",
        height: 54,
        elevation: 0,
        borderRadius: 16,
        fullWidth: true,
        onTap: () {
          UNavigator.back();
          UToast.toast(message: U.s.comingSoon);
        },
      ),
      UButton(
        title: U.s.cancel,
        height: 54,
        elevation: 0,
        borderRadius: 16,
        fullWidth: true,
        backgroundColor: scheme.primary.withValues(alpha: 0.1),
        foregroundColor: scheme.primary,
        onTap: UNavigator.back,
      ),
    ],
  );
}
