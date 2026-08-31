import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class TransactionTile extends StatelessWidget {
  const TransactionTile(
    this.info, {
    this.onTap,
    super.key,
  });

  final TransactionInfo info;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isCredit = info.debitType == 0;
    final Color accent = isCredit ? AppColors.success : scheme.primary;
    final String sign = isCredit ? "+ " : "− ";

    return UContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          UIconBackground(
            info.terminalTypeIconData(),
            color: accent,
            size: 34,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UTextBodyMedium(
                  info.merchantName ?? "",
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                UTextLabelSmall(
                  info.logDate?.formatJalaliDateTime() ?? "",
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          UTextBodyMedium(
            "$sign${info.transactionAmount?.rial() ?? "0"}",
            color: isCredit ? AppColors.success : scheme.onSurface,
            fontWeight: FontWeight.bold,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}

// class TransactionTile extends StatelessWidget {
//   const TransactionTile(this.transaction, {this.showDivider = true, super.key});
//
//   final TransactionModel transaction;
//   final bool showDivider;
//
//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme scheme = Theme.of(context).colorScheme;
//     final bool isCredit = transaction.direction == TransactionDirection.credit;
//     final Color accent = isCredit ? AppColors.success : scheme.primary;
//     final String sign = isCredit ? "+ " : "− ";
//     return UContainer(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       border: showDivider ? Border(bottom: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6))) : null,
//       child: Row(
//         children: <Widget>[
//           UIconBackground(transaction.icon, color: accent, size: 34),
//           const SizedBox(width: 11),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 UTextBodyMedium(transaction.title, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
//                 const SizedBox(height: 3),
//                 UTextLabelSmall(transaction.subtitle, color: scheme.onSurfaceVariant),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           UTextBodyMedium(
//             "$sign${transaction.amount.separate3By3()}",
//             color: isCredit ? AppColors.success : scheme.onSurface,
//             fontWeight: FontWeight.bold,
//             textDirection: TextDirection.ltr,
//           ),
//         ],
//       ),
//     );
//   }
// }
