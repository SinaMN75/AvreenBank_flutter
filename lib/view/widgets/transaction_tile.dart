import "package:avreen_bank/main.dart";
import "package:avreen_bank/model/transaction_model.dart";
import "package:u/utilities.dart";

class TransactionTile extends StatelessWidget {
  const TransactionTile(this.transaction, {this.showDivider = true, super.key});

  final TransactionModel transaction;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isCredit = transaction.direction == TransactionDirection.credit;
    final Color accent = isCredit ? AppColors.success : scheme.primary;
    final String sign = isCredit ? "+ " : "− ";
    return UContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: showDivider ? Border(bottom: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6))) : null,
      child: Row(
        children: <Widget>[
          UIconBackground(transaction.icon, color: accent, size: 34),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UTextBodyMedium(transaction.title, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                UTextLabelSmall(transaction.subtitle, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(width: 10),
          UTextBodyMedium(
            "$sign${transaction.amount.separate3By3()}",
            color: isCredit ? AppColors.success : scheme.onSurface,
            fontWeight: FontWeight.bold,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
