import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/statements/statement_controller.dart";
import "package:u/utilities.dart";

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({required this.accountInfo, super.key});

  final AccountInfo accountInfo;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      appBar: AppBar(
        title: Text("${U.s.statement} ${widget.accountInfo.accountTypeName ?? ""}"),
        bottom: TabBar(tabs: _tabs),
      ),
      body: TabBarView(children: <Widget>[byCount(), byDate()]),
    ),
  );

  Widget byCount() => Obx(
    () => UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      children: <Widget>[
        Form(
          key: c.byCountKey,
          child: UTextField(
            text: "تعداد تراکنش",
            controller: c.controllerCount,
            keyboardType: TextInputType.number,
            maxLength: 3,
            validator: UValidators.number(),
          ).pSymmetric(vertical: 12),
        ),
        UButton(onTap: c.getTransactionsByCount, title: "دریافت").pSymmetric(vertical: 12),
        if (c.state.isLoading())
          const UProgressCircular().alignAtCenter()
        else if (c.state.isEmpty())
          const Text("رکوردی یافت نشد.")
        else if (c.state.isLoaded())
          statementList(c.byCountList).pSymmetric(vertical: 20),
      ],
    ),
  );

  Widget byDate() => Obx(
    () => UColumn(
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      children: <Widget>[
        Row(
          children: <Widget>[
            UTextFieldDatePicker(
              readOnly: true,
              controller: c.controllerStartDate,
              text: U.s.startDate,
              onChange: (DateTime d, Jalali j) async {
                c.startDate(j);
                c.controllerStartDate.text = j.formatCompactDate();
              },
            ).pSymmetric(horizontal: 12).expanded(),
            UTextFieldDatePicker(
              readOnly: true,
              controller: c.controllerEndDate,
              text: U.s.endDate,
              onChange: (DateTime d, Jalali j) async {
                c.endDate(j);
                c.controllerEndDate.text = c.endDate.value.formatCompactDate();
              },
            ).pSymmetric(horizontal: 12).expanded(),
          ],
        ),
        UButton(onTap: c.getTransactionsByDate, title: "دریافت").pSymmetric(vertical: 12),
        if (c.state.isLoading())
          const UProgressCircular().alignAtCenter()
        else if (c.state.isEmpty())
          const Text("رکوردی یافت نشد.")
        else if (c.state.isLoaded())
          statementList(c.byDateList).pSymmetric(vertical: 20),
      ],
    ),
  );

  Widget statementList(List<StatementElement> list, {ScrollController? scrollController}) => ListView.builder(
    controller: scrollController,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) => statementItem(list[index]),
  );

  Widget statementItem(StatementElement i) => UCard(
    margin: const EdgeInsets.symmetric(vertical: 4),
    color: i.type == "L" ? Colors.yellow.shade50 : null,
    child: UColumn(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      children: <Widget>[
        UKeyValue(
          leading: UTextBodyLarge(i.transactionAmount.rial(), color: i.transactionAmount!.isNegative ? Colors.red : Colors.green),
          trailing: UTextBodyMedium(i.voucherDate.formatJalaliDateTime()),
        ),
        const SizedBox(height: 8),
        UKeyValue(
          leading: UTextBodySmall("مانده قبل: ${i.preBalance.toString().separateNumbers3By3()}"),
          trailing: UTextBodySmall("مانده بعد: ${i.balance.toString().separateNumbers3By3()}"),
        ),
        const SizedBox(height: 12),
        UTextBodySmall(i.description.toString()),
      ],
    ),
  );
}
