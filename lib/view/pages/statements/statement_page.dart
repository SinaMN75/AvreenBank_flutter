import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/statements/statement_controller.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:avreen_bank/view/widgets/statement.dart";
import "package:u/utilities.dart";

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({required this.accountInfo, super.key});

  final AccountInfo accountInfo;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends UState<TransactionsPage> {
  final StatementController c = StatementController();
  static final List<Tab> _tabs = <Tab>[const Tab(text: "براساس تعداد"), const Tab(text: "براساس تاریخ")];

  @override
  void initState() {
    super.initState();
    c.selectedAccount = widget.accountInfo;
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: _tabs.length,
    child: UScaffold(
      safeArea: false,
      body: Column(
        children: <Widget>[
          PageHeader(
            title: U.s.statement,
            subtitle: widget.accountInfo.accountTypeName,
            trailing: "${(widget.accountInfo.availableBalance ?? 0).separate3By3().toPersianNumber()} ${U.s.rial}",
          ),
          TabBar(tabs: _tabs, indicatorWeight: 3).pSymmetric(horizontal: 16, vertical: 8),
          TabBarView(children: <Widget>[byCount(), byDate()]).expanded(),
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
        _result(c.byCountList),
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
        _submit(c.getTransactionsByDate),
        _result(c.byDateList),
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

  Widget _result(List<StatementElement> list) {
    if (c.state.isLoading()) return const UProgressCircular().alignAtCenter().pOnly(top: 24);
    if (c.state.isEmpty()) return UEmptyState(title: U.s.noResults).pOnly(top: 24);
    if (c.state.isLoaded()) return StatementListView(list: list).pOnly(top: 4, bottom: 20);
    return const SizedBox();
  }
}
