import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/charge_history/charge_history_controller.dart";
import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:u/utilities.dart";

class ChargeHistoryPage extends StatefulWidget {
  const ChargeHistoryPage({required this.accountInfo, super.key});

  final AccountInfo accountInfo;

  @override
  State<ChargeHistoryPage> createState() => _ChargeHistoryPageState();
}

class _ChargeHistoryPageState extends UState<ChargeHistoryPage> {
  final ChargeHistoryController c = ChargeHistoryController();

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
          title: U.s.chargeReport,
          subtitle: widget.accountInfo.accountTypeName,
          trailing: "${(widget.accountInfo.availableBalance ?? 0).separate3By3().toPersianNumber()} ${U.s.rial}",
        ),
        UObx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                spacing: 12,
                children: <Widget>[
                  _dateBox(U.s.startDate, c.fromDate.value, c.pickStartDate),
                  _dateBox(U.s.endDate, c.toDate.value, c.pickEndDate),
                ],
              ).pOnly(top: 16),
              UButton(
                title: "دریافت",
                onTap: c.read,
                height: 54,
                elevation: 0,
                borderRadius: 16,
                fullWidth: true,
              ).pOnly(top: 12),
              USegmentedControl<bool>(
                items: <bool, String>{
                  false: U.s.descending,
                  true: U.s.ascending,
                },
                selectedValue: c.ascending.value,
                onValueChanged: c.changeOrder,
              ).pSymmetric(vertical: 12),
            ],
          ).pSymmetric(horizontal: 16),
        ),
        UObx(
          () {

            if (c.state.isLoading()) return const UProgressCircular().alignAtTopCenter().pOnly(top: 24);
            if (c.state.isEmpty()) return UEmptyState(title: U.s.noResults).alignAtTopCenter().pOnly(top: 24);
            if (c.state.isError()) return UErrorRetry(onTap: c.read).alignAtTopCenter().pOnly(top: 24);
            return RefreshIndicator.adaptive(
              onRefresh: c.read,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: c.list.length,
                separatorBuilder: (BuildContext _, int _) => const SizedBox(height: 14),
                itemBuilder: (BuildContext context, int index) => _item(c.list[index]),
              ),
            );
          },
        ).expanded(),
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

  Widget _item(CreditChargeLog i) => UContainer(
    radius: 24,
    color: scheme.surface,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          spacing: 12,
          children: <Widget>[
            UIconBackground(
              Icons.bolt_rounded,
              color: scheme.primary,
              backgroundColor: scheme.primary.withValues(alpha: 0.12),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: <Widget>[
                UTextTitleSmall(i.eventName ?? U.s.charge, fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
                UTextBodySmall(i.chargeDate?.toJalaliDateTime() ?? "---", color: scheme.onSurfaceVariant).ltr(),
              ],
            ).expanded(),
          ],
        ),
        const Divider(height: 12),
        UKeyValue(
          leading: UTextBodyMedium("موجودی", color: theme.disabledColor),
          trailing: Text(i.chargeAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("توان پرداخت", color: theme.disabledColor),
          trailing: Text(i.requestChargeAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("بدهی اعتباری", color: theme.disabledColor),
          trailing: Text(i.creditDebit.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("بدهی تسهیلاتی", color: theme.disabledColor),
          trailing: Text(i.insDebit.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
      ],
    ),
  );
}
