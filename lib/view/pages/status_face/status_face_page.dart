import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/status_face/status_face_controller.dart";
import "package:avreen_bank/view/widgets/app_sheet.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

class StatusFacePage extends StatefulWidget {
  const StatusFacePage({required this.accountInfo, super.key});

  final AccountInfo accountInfo;

  @override
  State<StatusFacePage> createState() => _StatusFacePageState();
}

class _StatusFacePageState extends UState<StatusFacePage> {
  final StatusFaceController c = StatusFaceController();

  List<Tab> get _tabs => <Tab>[
    const Tab(text: "جاری"),
    Tab(text: U.s.past),
    Tab(text: U.s.settled),
  ];

  @override
  void initState() {
    c.init(accountInfo: widget.accountInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: _tabs.length,
    child: UScaffold(
      safeArea: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PageHeader(
            title: "صورت وضعیت",
            subtitle: widget.accountInfo.accountTypeName,
            trailing: "${(widget.accountInfo.availableBalance ?? 0).separate3By3().toPersianNumber()} ${U.s.rial}",
          ),
          TabBar(tabs: _tabs, indicatorWeight: 3).pSymmetric(horizontal: 16, vertical: 8),
          TabBarView(
            children: <Widget>[
              current(),
              byDate(filter: c.past, onSubmit: c.readPast),
              byDate(filter: c.settled, onSubmit: c.readSettled),
            ],
          ).expanded(),
        ],
      ),
    ),
  );

  Widget current() => UObx(
    () {
      if (c.state.isEmpty())
        return UContainer(
          radius: 24,
          color: scheme.surface,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: UTextBodyMedium(
            "برای این پرونده صورت وضعیت جاری وجود ندارد",
            color: scheme.onSurfaceVariant,
            height: 2,
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ).alignAtTopCenter();
      else if (c.state.isLoaded())
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: c.list.length,
          separatorBuilder: (BuildContext _, int _) => const SizedBox(height: 14),
          itemBuilder: (BuildContext context, int index) => _item(info: c.list[index]),
        );
      else if (c.state.isLoading())
        return const UProgressCircular().alignAtTopCenter().pOnly(top: 24);
      else
        return const SizedBox();
    },
  );

  Widget byDate({required CreditStatementFilter filter, required VoidCallback onSubmit}) => UObx(
    () => UColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      scrollable: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        Row(
          spacing: 12,
          children: <Widget>[
            _dateBox(U.s.startDate, filter.startDate.value, filter.pickStartDate),
            _dateBox(U.s.endDate, filter.endDate.value, filter.pickEndDate),
          ],
        ).pSymmetric(vertical: 8),
        _submit(onSubmit),
        _result(filter.state, filter.list),
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
    child: UIconTextVertical(
      leading: UTextBodySmall(label, color: scheme.onSurfaceVariant),
      trailing: UTextTitleSmall(date.formatCompactDate(persianDigits: true), fontWeight: FontWeight.bold),
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

  Widget _result(URxState state, List<CreditStatement> list) {
    if (state.isLoading()) return const UProgressCircular().alignAtCenter().pOnly(top: 24);
    if (state.isEmpty()) return UEmptyState(title: U.s.noResults).pOnly(top: 24);
    if (!state.isLoaded()) return const SizedBox();
    return UColumn(
      spacing: 14,
      margin: const EdgeInsets.only(top: 4, bottom: 20),
      children: list.map((CreditStatement info) => _item(info: info)).toList(),
    );
  }

  Widget _item({required CreditStatement info}) => UContainer(
    radius: 24,
    color: scheme.surface,
    child: UColumn(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        UKeyValue(
          leading: UTextBodyMedium("تاریخ سررسید", color: theme.disabledColor),
          trailing: Text(info.dueDate?.toJalaliDateTime() ?? "---").ltr(),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("وضعیت", color: theme.disabledColor),
          trailing: Text(info.statusText()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("بدهی اعتباری", color: theme.disabledColor),
          trailing: Text(info.creditDebt.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("مانده بدهی اعتباری", color: theme.disabledColor),
          trailing: Text(info.remainCreditDebt.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("بدهی تسهیلاتی", color: theme.disabledColor),
          trailing: Text(info.loanDebt.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("مانده بدهی تسهیلاتی", color: theme.disabledColor),
          trailing: Text(info.remainLoanDebt.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        URow(
          children: <Widget>[
            UButton(
              title: U.s.creditDebt,
              height: 50,
              elevation: 0,
              borderRadius: 16,
              margin: const EdgeInsets.only(top: 8),
              expanded: 1,
              onTap: () => c.readCreditDetails(billId: info.id, onOk: showCreditDetails),
            ),
            const SizedBox(width: 20),
            UButton(
              title: U.s.loanDebt,
              height: 50,
              elevation: 0,
              borderRadius: 16,
              margin: const EdgeInsets.only(top: 8),
              expanded: 1,
              onTap: () => c.readLoanDetails(billId: info.id, onOk: showLoanDetails),
            ),
          ],
        ),
      ],
    ),
  );

  void showCreditDetails(List<StatementCreditDetail> list) => AppSheet.show<void>(
    title: U.s.creditPurchases,
    children: list.isEmpty ? <Widget>[const UEmptyState(icon: Icons.receipt_long_outlined).pSymmetric(vertical: 32)] : list.map(_creditDetailItem).toList(),
  );

  Widget _creditDetailItem(StatementCreditDetail i) => UContainer(
    radius: 18,
    color: scheme.onSurface.withValues(alpha: 0.04),
    padding: const EdgeInsets.all(12),
    child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: UIconBackground(
            Icons.credit_card_outlined,
            color: scheme.primary,
            backgroundColor: scheme.primary.withValues(alpha: 0.12),
          ),
          title: UTextBodySmall(U.s.totalAmount, color: scheme.onSurfaceVariant),
          subtitle: UTextTitleMedium(i.amount.rial(), fontWeight: FontWeight.bold),
          trailing: UTextBodySmall(i.date?.toJalaliCompactDateString() ?? "---", color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        if (i.description.isNotNullOrEmpty()) UTextBodySmall(i.description!, color: scheme.onSurfaceVariant, maxLines: 3, textAlign: TextAlign.center),
      ],
    ),
  );

  void showLoanDetails(List<StatementLoanDetail> list) => AppSheet.show<void>(
    title: U.s.installmentPurchases,
    children: list.isEmpty ? <Widget>[const UEmptyState(icon: Icons.receipt_long_outlined).pSymmetric(vertical: 32)] : list.map(_loanDetailItem).toList(),
  );

  Widget _loanDetailItem(StatementLoanDetail i) => UContainer(
    radius: 18,
    color: scheme.onSurface.withValues(alpha: 0.04),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: UIconBackground(
            Icons.shopping_bag_outlined,
            color: scheme.primary,
            backgroundColor: scheme.primary.withValues(alpha: 0.12),
          ),
          title: UTextBodySmall(U.s.totalAmount, color: scheme.onSurfaceVariant),
          subtitle: UTextTitleMedium(i.totalAmount.rial(), fontWeight: FontWeight.bold),
          trailing: UTextBodySmall(i.date?.toJalaliDateTime() ?? "---", color: scheme.onSurfaceVariant, textDirection: TextDirection.ltr),
        ),
        const Divider(height: 24),
        UKeyValue(
          leading: UTextBodyMedium(U.s.installments, color: theme.disabledColor),
          trailing: Text("${i.instalmentCount ?? 0} قسط "),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium(U.s.loanDebt, color: theme.disabledColor),
          trailing: UTextBodyMedium(i.loanDebt.rial(), color: i.payStatus == 1 ? AppColors.orange : AppColors.success, fontWeight: FontWeight.w600),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium(U.s.status, color: theme.disabledColor),
          trailing: UTextBodyMedium(i.payStatus == 1 ? "پرداخت نشده" : U.s.paid, color: i.payStatus == 1 ? AppColors.orange : AppColors.success, fontWeight: FontWeight.w600),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        const SizedBox(height: 6),
        if (i.description.isNotNullOrEmpty()) UTextBodySmall(i.description!, color: scheme.onSurfaceVariant, maxLines: 3, textAlign: TextAlign.center),
      ],
    ),
  );
}
