import "package:avreen_bank/data/iran_banks.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/model/card_model.dart";
import "package:u/utilities.dart";

class BankCardView extends StatelessWidget {
  const BankCardView(this.card, {required this.selected, this.height = 190, super.key});

  final CardModel card;
  final bool selected;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bool isIran = IranBanks.isIranianCard(card.number);
    final CardBrand brand = CardBrandDetector.detect(card.number);
    final List<Color> colors = isIran ? IranBanks.gradientOf(card.bin) : CardBrandDetector.gradientColors(brand);
    final String? asset = isIran ? IranBanks.assetOf(card.bin) : null;
    final Widget? logo = asset == null
        ? null
        : UContainer(
            color: AppColors.onGradient,
            radius: 6,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: UImage(asset, height: 20),
          );
    return AnimatedScale(
      scale: selected ? 1 : 0.93,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: selected ? 1 : 0.7,
        duration: const Duration(milliseconds: 250),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => CreditCardWidget(
            width: constraints.maxWidth,
            height: height,
            cardNumber: _mask(card.number),
            expiryDate: card.expiry,
            cardHolderName: card.holder,
            cvvCode: "",
            showBackView: false,
            obscureCardNumber: false,
            gradient: LinearGradient(colors: colors, begin: Alignment.topRight, end: Alignment.bottomLeft),
            title: isIran ? IranBanks.nameOf(card.number) : null,
            logo: logo,
            brandLabel: isIran ? null : CardBrandDetector.label(brand),
          ),
        ),
      ),
    );
  }

  String _mask(String number) {
    if (number.length < 10) return number;
    final String head = number.substring(0, 6);
    final String tail = number.substring(number.length - 4);
    return "${head.substring(0, 4)} ${head.substring(4)}•• •••• $tail";
  }
}
