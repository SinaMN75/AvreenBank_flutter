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
    final bool isCredit = info.isCredit();

    return UContainer(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: <Widget>[
          UIconBackground(info.terminalTypeIconData(), color: isCredit ? AppColors.success : scheme.primary, size: 34),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UTextBodyMedium(info.merchantName ?? "", fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                UTextLabelSmall(info.logDate?.formatJalaliDateTime() ?? "", color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(width: 10),
          UTextBodyMedium(
            info.transactionAmount?.rial() ?? "0",
            color: isCredit ? AppColors.success : scheme.error,
            maxLines: 2,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
