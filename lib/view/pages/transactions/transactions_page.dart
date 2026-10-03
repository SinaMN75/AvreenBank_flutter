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

class _TransactionsPageState extends UState<TransactionsPage> {
  final TransactionsController c = TransactionsController();
  static final List<Tab> _tabs = <Tab>[
    const Tab(text: "امروز"),
    const Tab(text: "براساس تعداد"),
    const Tab(text: "براساس تاریخ"),
  ];

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: _tabs.length,
    child: UScaffold(
      safeArea: false,
      body: Column(
        children: <Widget>[
          PageHeader(
            title: "تراکنش‌های کارت",
            subtitle: widget.card == null ? null : "کارت اعتباری — ${widget.card!.lastFour().toPersianNumber()}",
          ),
          TabBar(tabs: _tabs, indicatorWeight: 3).pSymmetric(horizontal: 16, vertical: 8),
          TabBarView(children: <Widget>[today(), byCount(), byDate()]).expanded(),
        ],
      ),
    ),
  );

  Widget byCount() => UObx(
    () => UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        Form(
          key: c.byCountKey,
          child: UTextField(
            labelText: "تعداد تراکنش",
            controller: c.controllerCount,
            keyboardType: TextInputType.number,
            maxLength: 3,
            validator: UValidators.number(),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ).pSymmetric(vertical: 8),
        ),
        _submit(c.getTransactionsByCount),
        _result(c.byCountState, c.byCountList),
      ],
    ),
  );

  Widget byDate() => UObx(
    () => UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        Row(
          spacing: 12,
          children: <Widget>[
            _dateBox(U.s.endDate, c.endDate.value, c.pickEndDate),
            _dateBox(U.s.startDate, c.startDate.value, c.pickStartDate),
          ],
        ).pSymmetric(vertical: 8),
        _submit(
          () {
            c.getTransactionsByDate();
          },
        ),
        _result(c.byDateState, c.byDateList),
      ],
    ),
  );

  Widget today() => UObx(
    () => UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        _result(c.todayState, c.todayList),
      ],
    ),
  );

  Widget _dateBox(String label, UJalali date, VoidCallback onTap) => UContainer(
    expanded: 1,
    radius: 16,
    color: scheme.surface,
    border: Border.all(color: scheme.outlineVariant),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: <Widget>[
        UTextBodySmall(label, color: scheme.onSurfaceVariant),
        UTextTitleSmall(date.formatCompactDate(persianDigits: true), fontWeight: FontWeight.bold),
      ],
    ),
  );

  Widget _submit(VoidCallback onTap) => UButton(
    title: "دریافت",
    onTap: onTap,
    height: 54,
    elevation: 0,
    borderRadius: 16,
    fullWidth: true,
  ).pSymmetric(vertical: 12);

  Widget _result(URxState state, List<TransactionInfo> list) {
    if (state.isLoading()) return const UProgressCircular().alignAtCenter().pOnly(top: 24);
    if (state.isEmpty()) return UEmptyState(title: U.s.noResults).pOnly(top: 24);
    if (!state.isLoaded()) return const SizedBox();
    return Column(
      spacing: 14,
      children: list
          .map(
            (TransactionInfo info) => TransactionItem(
              amount: info.transactionAmount ?? 0,
              positive: info.isRefund(),
              description: info.description(),
              date: info.logDate,
              onTap: () => UNavigator.push(ReceiptPage(info)),
            ),
          )
          .toList(),
    ).pOnly(top: 4, bottom: 20);
  }
}
