import "package:avreen_bank/model/card_model.dart";
import "package:u/utilities.dart";

class BankCardView extends StatelessWidget {
  const BankCardView(
    this.card, {
    required this.selected,
    required this.statusLabel,
    required this.balanceHidden,
    this.onTap,
    this.width,
    super.key,
  });

  final CardModel card;
  final bool selected;
  final String statusLabel;
  final bool balanceHidden;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color fg = selected ? scheme.onPrimary : scheme.onSurface;
    final Color muted = selected ? scheme.onPrimary.withValues(alpha: 0.75) : scheme.onSurfaceVariant;
    return UContainer(
      width: width,
      color: selected ? scheme.primary : scheme.surface,
      radius: 20,
      border: Border.all(color: selected ? scheme.primary : scheme.outlineVariant),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          UKeyValue(
            leading: UTextBodySmall(card.label, color: fg),
            trailing: UTextLabelSmall(statusLabel, color: muted),
          ),
          const SizedBox(height: 16),
          UTextTitleMedium(card.pan, color: fg, letterSpacing: 2, textDirection: TextDirection.ltr),
          const SizedBox(height: 16),
          UKeyValue(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UTextLabelSmall(U.s.balance, color: muted),
                const SizedBox(height: 2),
                UTextTitleMedium(balanceHidden ? "••••••" : card.balance.separate3By3(), color: fg, fontWeight: FontWeight.bold),
              ],
            ),
            trailing: UTextLabelSmall(card.expiry, color: muted, textDirection: TextDirection.ltr),
          ),
        ],
      ),
    ).onTap(onTap);
  }
}
