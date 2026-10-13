import "package:avreen_bank/data/data.dart";
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

  @override
  void initState() {
    c.init(accountInfo: widget.accountInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PageHeader(
          title: U.s.statement,
          subtitle: widget.accountInfo.accountTypeName,
          trailing: "${(widget.accountInfo.availableBalance ?? 0).separate3By3().toPersianNumber()} ${U.s.rial}",
        ),
        UObx(
          () {
            if (c.state.isEmpty())
              return UContainer(
                radius: 24,
                color: scheme.surface,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: UTextBodyMedium(
                  "برای این پرونده هنوز قسط فعالی ثبت نشده است. وقتی خرید اقساطی انجام شود، اینجا دیده می‌شود.",
                  color: scheme.onSurfaceVariant,
                  height: 2,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
              ).alignAtTopCenter();
            else if (c.state.isLoaded())
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: c.list.length,
                separatorBuilder: (BuildContext _, int _) => const SizedBox(height: 14),
                itemBuilder: (BuildContext context, int index) => _item(info: c.list[index]),
              );
            else if (c.state.isLoading())
              return const UProgressCircular().alignAtTopCenter();
            else
              return const SizedBox();
          },
        ).expanded(),
      ],
    ),
  );

  Widget _item({required CreditStatement info}) => UContainer(
    radius: 24,
    color: scheme.surface,
    child: UColumn(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        UKeyValue(
          leading: UTextBodyMedium("تاریخ سررسید", color: theme.disabledColor),
          trailing: Text(info.dueDate?.toJalaliCompactDateString() ?? "---"),
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
    children: list.isEmpty
        ? <Widget>[const UEmptyState(icon: Icons.receipt_long_outlined).pSymmetric(vertical: 32)]
        : list.map(_creditDetailItem).toList(),
  );

  Widget _creditDetailItem(StatementCreditDetail i) => UContainer(
    radius: 18,
    color: scheme.onSurface.withValues(alpha: 0.04),
    padding: const EdgeInsets.all(16),
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
        const Divider(height: 24),
        UKeyValue(
          leading: UTextBodyMedium(U.s.documentNumber, color: theme.disabledColor),
          trailing: Text(i.docId ?? "---"),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        const SizedBox(height: 6),
        if (i.description.isNotNullOrEmpty()) UTextBodySmall(i.description!, color: scheme.onSurfaceVariant, maxLines: 3, textAlign: TextAlign.center),
      ],
    ),
  );

  void showLoanDetails(List<StatementLoanDetail> list) => AppSheet.show<void>(
    title: U.s.installmentPurchases,
    children: list.isEmpty
        ? <Widget>[const UEmptyState(icon: Icons.receipt_long_outlined).pSymmetric(vertical: 32)]
        : list.map(_loanDetailItem).toList(),
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
          trailing: UTextBodySmall(i.date?.toJalaliCompactDateString() ?? "---", color: scheme.onSurfaceVariant),
        ),
        const Divider(height: 24),
        UKeyValue(
          leading: UTextBodyMedium(U.s.installments, color: theme.disabledColor),
          trailing: Text("${i.instalmentCount ?? 0} قسط "),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium(U.s.loanDebt, color: theme.disabledColor),
          trailing: UTextBodyMedium(i.loanDebt.rial(), color: scheme.error, fontWeight: FontWeight.w600),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        const SizedBox(height: 6),
        if (i.description.isNotNullOrEmpty()) UTextBodySmall(i.description!, color: scheme.onSurfaceVariant, maxLines: 3, textAlign: TextAlign.center),
      ],
    ),
  );
}
