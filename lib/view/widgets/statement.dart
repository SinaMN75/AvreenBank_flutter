import "package:avreen_bank/data/data.dart";
import "package:u/utilities.dart";

class StatementListView extends StatelessWidget {
  const StatementListView({required this.list, super.key});

  final List<StatementElement> list;

  @override
  Widget build(BuildContext context) => ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) => StatementItem(list[index]),
  );
}

class StatementItem extends StatelessWidget {
  const StatementItem(this.i, {super.key});

  final StatementElement i;

  @override
  Widget build(BuildContext context) => UCard(
    margin: const EdgeInsets.symmetric(vertical: 4),
    color: i.type == "L" ? Colors.yellow.shade50 : null,
    child: UColumn(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      children: <Widget>[
        UKeyValue(
          leading: UTextBodyLarge(i.transactionAmount.rial(), color: i.transactionAmount!.isNegative ? Colors.red : Colors.green),
          trailing: UTextBodyMedium(i.voucherDate.formatJalaliDateTime()),
        ),
        const SizedBox(height: 12),
        UTextBodySmall(i.description.toString()),
      ],
    ),
  );
}
