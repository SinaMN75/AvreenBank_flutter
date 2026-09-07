import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/data/iran_banks.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class BankCardView extends StatefulWidget {
  const BankCardView(this.card, {required this.selected, this.height = 190, super.key});

  final PanInfo card;
  final bool selected;
  final double height;

  @override
  State<BankCardView> createState() => _BankCardViewState();
}

class _BankCardViewState extends State<BankCardView> {
  bool backView = false;

  @override
  Widget build(BuildContext context) {
    final bool isIran = IranBanks.isIranianCard(widget.card.pan);
    final CardBrand brand = CardBrandDetector.detect(widget.card.pan);
    final List<Color> colors = isIran ? IranBanks.gradientOf(widget.card.pan) : CardBrandDetector.gradientColors(brand);
    final String? asset = isIran ? IranBanks.assetOf(widget.card.pan) : null;
    final Widget? logo = asset == null
        ? null
        : UContainer(
            color: AppColors.onGradient,
            radius: 6,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: UImage(asset, height: 20),
          );
    return AnimatedScale(
      scale: widget.selected ? 1 : 0.93,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: widget.selected ? 1 : 0.7,
        duration: const Duration(milliseconds: 250),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => CreditCardWidget(
            width: constraints.maxWidth,
            height: widget.height,
            cardNumber: widget.card.pan.separateCharacters(4, "  "),
            expiryDate: widget.card.expiredDate == null ? "**/**" : "${widget.card.expiredDate!.substring(0, 2)}/${widget.card.expiredDate!.substring(2)}",
            cardHolderName: "${Core.fileInfo.value.firstName ?? "---"} ${Core.fileInfo.value.lastName ?? "---"}",
            cvvCode: widget.card.cvv2 ?? "***",
            showBackView: backView,
            gradient: LinearGradient(colors: colors, begin: Alignment.topRight, end: Alignment.bottomLeft),
            title: isIran ? IranBanks.nameOf(widget.card.pan) : null,
            logo: logo,
            brandLabel: isIran ? null : CardBrandDetector.label(brand),
          ).onTap(() => setState(() => backView = !backView)),
        ),
      ),
    );
  }
}
