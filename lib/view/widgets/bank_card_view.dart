import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class BankCardView extends StatelessWidget {
  const BankCardView(this.card, {required this.selected, this.height = 200, super.key});

  final PanInfo card;
  final bool selected;
  final double height;

  @override
  Widget build(BuildContext context) => AnimatedScale(
    scale: selected ? 1 : 0.93,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOut,
    child: AnimatedOpacity(
      opacity: selected ? 1 : 0.7,
      duration: const Duration(milliseconds: 250),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => UCreditCardWidget(
          width: constraints.maxWidth,
          height: height,
          cardNumber: card.pan.separateCharacters(4, " "),
          expiryDate: card.expiry() ?? "**/**",
          cardHolderName: "${Core.fileInfo.value.firstName ?? "---"} ${Core.fileInfo.value.lastName ?? "---"}",
          cvvCode: card.cvv2 ?? "***",
          showBackView: false,
          obscureCardNumber: false,
          borderRadius: 24,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
          chipColor: AppColors.cardChip,
          boxShadow: <BoxShadow>[BoxShadow(color: AppColors.brand.withValues(alpha: 0.25), blurRadius: 20, offset: const Offset(0, 10))],
          gradient: const LinearGradient(colors: AppColors.card, begin: Alignment.topLeft, end: Alignment.bottomRight),
          logo: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4,
            children: <Widget>[
              Text("حکمت نو", style: TextStyle(color: AppColors.onGradient, fontSize: 16, fontWeight: FontWeight.bold)),
              Text("کارت اعتباری", style: TextStyle(color: AppColors.onGradient, fontSize: 12)),
            ],
          ),
          spreadNumberGroups: true,
          numberStyle: const TextStyle(color: AppColors.onGradient, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),
          showCvvOnFront: true,
          cardHolderLabel: "دارنده کارت",
          expiryLabel: U.s.expires,
          cvvLabel: "CVV2",
          labelStyle: TextStyle(color: AppColors.onGradient.withValues(alpha: 0.75), fontSize: 11),
          valueStyle: const TextStyle(color: AppColors.onGradient, fontSize: 15, fontWeight: FontWeight.bold),
          digitsFormatter: (String value) => value.toPersianNumber(),
        ).ltr(),
      ),
    ),
  );
}
