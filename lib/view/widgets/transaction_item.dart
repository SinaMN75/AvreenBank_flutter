import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.amount,
    required this.positive,
    required this.description,
    this.date,
    this.onTap,
    super.key,
  });

  final int amount;
  final bool positive;
  final String description;
  final String? date;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color amountColor = positive ? AppColors.success : scheme.error;
    return UContainer(
      color: scheme.surface,
      radius: 20,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _icon(scheme),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: UTextTitleSmall(
                    "${positive ? "+" : "-"}${amount.abs().separate3By3().toPersianNumber()} ${U.s.rial}",
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                UTextBodyMedium(description, color: scheme.onSurface.withValues(alpha: 0.8), height: 1.9, maxLines: 4),
                if (date.isNotNullOrEmpty()) ...<Widget>[
                  const SizedBox(height: 8),
                  UTextLabelMedium(_formatDate(date!), color: scheme.onSurfaceVariant),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(ColorScheme scheme) {
    final Color color = positive ? AppColors.success : AppColors.orange;
    final Color badge = positive ? AppColors.success : scheme.error;
    return SizedBox(
      width: 42,
      height: 42,
      child: Stack(
        children: <Widget>[
          UContainer(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.08),
            border: Border.all(color: color.withValues(alpha: 0.3)),
            child: UContainer(width: 13, height: 13, shape: BoxShape.circle, color: color),
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: UContainer(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              shape: BoxShape.circle,
              color: badge,
              border: Border.all(color: scheme.surface, width: 1.5),
              child: Icon(positive ? Icons.add : Icons.remove, size: 11, color: AppColors.onGradient),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(String date) {
    final DateTime? dateTime = DateTime.tryParse(date)?.toLocal();
    if (dateTime == null) return date;
    return UJalali.fromDateTime(dateTime).formatCustom("yyyy/mm/dd - HH:MM:SS", persianDigits: true);
  }
}
