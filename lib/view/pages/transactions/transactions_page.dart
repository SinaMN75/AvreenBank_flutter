import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/receipt/receipt_page.dart";
import "package:avreen_bank/view/pages/transactions/transactions_controller.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:avreen_bank/view/widgets/transaction_item.dart";
import "package:u/utilities.dart";

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({this.card, super.key});

  final PanInfo? card;

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
    safeArea: false,
    body: UObx(
      () => Column(
        children: <Widget>[
          PageHeader(
            title: "تراکنش‌های کارت",
            subtitle: widget.card == null ? null : "کارت اعتباری — ${widget.card!.lastFour().toPersianNumber()}",
            trailing: c.state.isLoaded() ? "${c.transactions.length.toString().toPersianNumber()} مورد" : null,
          ),
          _body().expanded(),
        ],
      ),
    ),
  );

  Widget _body() {
    if (c.state.isLoading()) return const UProgressCircular().alignAtCenter();
    if (c.state.isEmpty()) return UEmptyState(title: U.s.noResults).alignAtCenter();
    if (!c.state.isLoaded()) return const SizedBox();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      itemCount: c.transactions.length,
      separatorBuilder: (BuildContext _, int _) => const SizedBox(height: 14),
      itemBuilder: (BuildContext _, int index) {
        final TransactionInfo info = c.transactions[index];
        return TransactionItem(
          amount: info.transactionAmount ?? 0,
          positive: info.isRefund(),
          description: info.description(),
          date: info.logDate,
          onTap: () => UNavigator.push(ReceiptPage(info)),
        );
      },
    );
  }
}
