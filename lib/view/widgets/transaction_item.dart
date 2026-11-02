import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/receipt/receipt_page.dart";
import "package:u/utilities.dart";

class TransactionItem extends StatelessWidget {
  const TransactionItem({required this.i, super.key});

  final TransactionInfo i;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    return UCard(
      color: scheme.surface,
      onTap: () {},
      child: ListTile(
        onTap: () => UNavigator.push(ReceiptPage(i)),
        leading: _icon(scheme, i),
        title: UTextBodyLarge(i.transactionAmount.rial(), color: i.color()),
        subtitle: UTextBodySmall(i.debitTypeName(), color: i.color()),
        trailing: UIconTextVertical(
          crossAxisAlignment: CrossAxisAlignment.end,
          leading: UTextLabelMedium(i.logDate.toJalaliDateTime(), color: scheme.onSurfaceVariant).ltr(),
          trailing: UTextLabelMedium("کد رهگیری: ${i.rrn ?? "---"}", color: scheme.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget _icon(ColorScheme scheme, TransactionInfo i) => SizedBox(
      width: 42,
      height: 42,
      child: Stack(
        children: <Widget>[
          UContainer(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            shape: BoxShape.circle,
            color: i.color().withValues(alpha: 0.08),
            border: Border.all(color: i.color().withValues(alpha: 0.3)),
            child: UContainer(width: 13, height: 13, shape: BoxShape.circle, color: i.color()),
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: UContainer(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              shape: BoxShape.circle,
              color: i.color(),
              border: Border.all(color: scheme.surface, width: 1.5),
            ),
          ),
        ],
      ),
    );
}
