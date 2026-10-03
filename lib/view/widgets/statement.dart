import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class StatementListView extends StatelessWidget {
  const StatementListView({required this.list, super.key});

  final List<StatementElement> list;

  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: list.length,
    separatorBuilder: (BuildContext _, int _) => const SizedBox(height: 12),
    itemBuilder: (BuildContext context, int index) {
      final StatementElement i = list[index];
      return StatementItem(
        amount: i.transactionAmount ?? 0,
        positive: !(i.transactionAmount ?? 0).isNegative,
        description: i.description ?? "",
        date: i.voucherDate,
      );
    },
  );
}

class StatementItem extends StatelessWidget {
  const StatementItem({
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
    return UCard(
      color: scheme.surface,
      onTap: onTap,
      child: UColumn(
        padding: const EdgeInsets.all(4),
        children: <Widget>[
          ListTile(
            leading: _icon(scheme),
            title: UTextBodySmall(amount.abs().rial(), color: amountColor),
            trailing: UTextLabelMedium(date!.toJalaliDateTime(), color: scheme.onSurfaceVariant).ltr(),
          ),
          UTextLabelSmall(
            description,
            color: scheme.onSurface.withValues(alpha: 0.8),
            maxLines: 3,
            textAlign: TextAlign.center,
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
}
