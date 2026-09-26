import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/widgets/transaction_item.dart";
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
    itemBuilder: (BuildContext context, int index) => StatementItem(list[index]),
  );
}

class StatementItem extends StatelessWidget {
  const StatementItem(this.i, {super.key});

  final StatementElement i;

  @override
  Widget build(BuildContext context) => TransactionItem(
    amount: i.transactionAmount ?? 0,
    positive: !(i.transactionAmount ?? 0).isNegative,
    description: i.description ?? "",
    date: i.voucherDate,
  );
}
