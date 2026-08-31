import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/statements/statement_controller.dart";
import "package:u/utilities.dart";

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final StatementController c = StatementController();
  static final List<Tab> _tabs = <Tab>[const Tab(text: "براساس تعداد"), const Tab(text: "براساس تاریخ")];

  @override
  void initState() {
    super.initState();
    if (mounted) c.getAccounts();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: _tabs.length,
    child: UScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      appBar: AppBar(
        title: Text(U.s.statement),
        bottom: TabBar(tabs: _tabs),
      ),
      body: Obx(() => c.pageState.isLoaded() ? TabBarView(children: <Widget>[byCount(), byDate()]) : const SizedBox()),
    ),
  );

  Widget byCount() => Obx(
    () => UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      children: <Widget>[
        Wrap(
          children: <Widget>[
            ...c.accountInfoList.map(
              (AccountInfo e) => UIconTextHorizontal(
                leading: Radio<String>(
                  value: e.accountId ?? "",
                  groupValue: c.selectedAccount.value,
                  onChanged: (String? value) {
                    c.selectedAccount(value!);
                    c.getAccountFunctionCodes();
                  },
                ),
                trailing: Text(e.accountTypeName ?? ""),
              ),
            ),
          ],
        ),
        c.functionList.length <= 1 ? const SizedBox() : const Text("فیلتر بر اساس عملیات اصلی").pSymmetric(vertical: 8),
        c.functionList.length <= 1
            ? const SizedBox()
            : DropdownButtonFormField<String>(
                value: c.functionList.first.functionCode,
                items: <DropdownMenuItem<String>>[
                  ...c.functionList.map((FunctionCodeList e) => DropdownMenuItem<String>(value: e.functionCode, child: Text(e.functionName!))),
                ],
                onChanged: (String? value) {
                  c.selectedFunctionCode?.call(c.functionList.singleWhere((FunctionCodeList e) => e.functionCode == value).functionCode);
                  c.selectedSubFunctionCode?.call("---");
                  try {
                    c.subFunctionList(c.functionList.singleWhere((FunctionCodeList e) => e.functionCode == c.selectedFunctionCode?.value).subFunctionCodeList);
                    c.selectedSubFunctionCode?.call(c.subFunctionList.first.subFunctionCode);
                  } catch (e) {
                    c.subFunctionList.clear();
                    c.selectedSubFunctionCode?.call("---");
                  }
                },
              ).pSymmetric(vertical: 8),
        c.subFunctionList.isEmpty ? const SizedBox() : const Text("فیلتر بر اساس عملیات فرعی").pSymmetric(vertical: 8),
        c.subFunctionList.isEmpty
            ? const SizedBox()
            : DropdownButtonFormField<String>(
                value: c.selectedSubFunctionCode?.value,
                items: <DropdownMenuItem<String>>[
                  ...c.subFunctionList.map((SubFunctionCodeList e) => DropdownMenuItem<String>(value: e.subFunctionCode, child: Text(e.subFunctionName!))),
                ],
                onChanged: c.selectedSubFunctionCode?.call,
              ),
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
        statementList(c.byCountList).pSymmetric(vertical: 20),
      ],
    ),
  );

  Widget byDate() => Obx(
    () => UColumn(
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      children: <Widget>[
        Wrap(
          children: <Widget>[
            ...c.accountInfoList.map(
              (AccountInfo e) => UIconTextHorizontal(
                leading: Radio<String>(
                  value: e.accountId ?? "",
                  groupValue: c.selectedAccount.value,
                  onChanged: (String? value) {
                    c.selectedAccount(value!);
                    c.getAccountFunctionCodes();
                  },
                ),
                trailing: Text(e.accountTypeName ?? ""),
              ),
            ),
          ],
        ),
        // c.functionList.isEmpty ? const SizedBox() : const Text("فیلتر بر اساس عملیات اصلی").pSymmetric(vertical: 8),
        // c.functionList.isEmpty
        //     ? const SizedBox()
        //     : DropdownButtonFormField<String>(
        //         value: c.functionList.first.functionCode,
        //         items: <DropdownMenuItem<String>>[
        //           ...c.functionList.map((FunctionCodeList e) => DropdownMenuItem<String>(value: e.functionCode, child: Text(e.functionName!))),
        //         ],
        //         onChanged: (String? value) {
        //           c.selectedFunctionCode?.call(c.functionList.singleWhere((FunctionCodeList e) => e.functionCode == value).functionCode);
        //           c.selectedSubFunctionCode?.call(
        //             c.functionList
        //                 .singleWhere(
        //                   (FunctionCodeList e) => e.functionCode == c.selectedFunctionCode?.value,
        //                 )
        //                 .subFunctionCodeList!
        //                 .first
        //                 .subFunctionCode,
        //           );
        //           c.subFunctionList(c.functionList.singleWhere((FunctionCodeList e) => e.functionCode == c.selectedFunctionCode?.value).subFunctionCodeList);
        //         },
        //       ).pSymmetric(vertical: 8),
        // Obx(() => c.subFunctionList.isEmpty ? const SizedBox() : const Text("فیلتر بر اساس عملیات فرعی").pSymmetric(vertical: 8)),
        // Obx(
        //   () => c.subFunctionList.isEmpty
        //       ? const SizedBox()
        //       : DropdownButtonFormField<String>(
        //           value: c.selectedSubFunctionCode?.value,
        //           items: <DropdownMenuItem<String>>[
        //             ...c.subFunctionList.map((SubFunctionCodeList e) => DropdownMenuItem<String>(value: e.subFunctionCode, child: Text(e.subFunctionName!))),
        //           ],
        //           onChanged: c.selectedSubFunctionCode?.call,
        //         ),
        // ),
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
        statementList(c.byDateList).pSymmetric(vertical: 20),
      ],
    ),
  );

  Widget statementList(List<StatementElement> list, {ScrollController? scrollController}) => list.isEmpty
      ? const Text("رکوردی یافت نشد.")
      : ListView.builder(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) => statementItem(list[index]),
        );

  Widget statementItem(StatementElement i) => Card(
    color: i.type == "L" ? Colors.yellow.shade50 : null,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            UTextBodyLarge(i.transactionAmount.rial(), color: i.transactionAmount!.isNegative ? Colors.red : Colors.green),
            UTextBodyMedium(i.voucherDate.formatJalaliDateTime()),
          ],
        ).pSymmetric(vertical: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            UTextBodySmall("مانده قبل: ${i.preBalance.toString().separateNumbers3By3()}"),
            UTextBodySmall("مانده بعد: ${i.balance.toString().separateNumbers3By3()}"),
          ],
        ).pSymmetric(vertical: 8),
        UTextBodySmall(i.description.toString()),
      ],
    ).pAll(8),
  );
}
