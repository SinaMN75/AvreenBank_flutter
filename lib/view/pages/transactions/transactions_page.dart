import "package:avreen_bank/view/pages/transactions/transactions_controller.dart";
import "package:avreen_bank/view/widgets/transaction_tile.dart";
import "package:u/utilities.dart";

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionsController c = TransactionsController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    appBar: AppBar(title: Text(U.s.transactions)),
    body: Obx(() {
      if (c.state.isLoaded())
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext _, int index) => TransactionTile(c.transactions[index]),
          separatorBuilder: (BuildContext _, int _) => const Divider(),
          itemCount: c.transactions.length,
        );
      else if (c.state.isLoading())
        return const UProgressCircular().alignAtCenter();
      else if (c.state.isLoading())
        return const UEmptyState();
      else
        return const SizedBox();
    }),
  );
}
