import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/status_face/status_face_controller.dart";
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
              title: "بدهی اعتباری",
              height: 50,
              elevation: 0,
              borderRadius: 16,
              margin: const EdgeInsets.only(top: 8),
              expanded: 1,
              onTap: () => showCreditDetails(list: <InstallmentsStatus>[]),
            ),
            const SizedBox(width: 20),
            UButton(
              title: "بدهی تسهیلاتی",
              height: 50,
              elevation: 0,
              borderRadius: 16,
              margin: const EdgeInsets.only(top: 8),
              expanded: 1,
              onTap: () => showLoanDetails(list: <InstallmentsStatus>[]),
            ),
          ],
        ),
      ],
    ),
  );

  void showCreditDetails({required List<InstallmentsStatus> list}) {
    final URxList<InstallmentsStatus> filteredList = list.obs;
    UNavigator.draggableSheet(
      UColumn(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          UObx(
            () => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 12),
              shrinkWrap: true,
              itemCount: filteredList.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final InstallmentsStatus i = filteredList[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    title: UTextBodyMedium(i.amount.rial(), color: i.statusColor()),
                    subtitle: Text(i.dueDate.toJalaliDateString()),
                    trailing: Text(i.dueDate.toJalaliDateString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showLoanDetails({required List<InstallmentsStatus> list}) {
    final URxList<InstallmentsStatus> filteredList = list.obs;
    UNavigator.draggableSheet(
      UColumn(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          UObx(
            () => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 12),
              shrinkWrap: true,
              itemCount: filteredList.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) => Card(
                child: UColumn(
                  padding: const EdgeInsets.all(12),
                  children: <Widget>[
                    UKeyValue(
                      leading: UTextBodyMedium("تاریخ", color: theme.disabledColor),
                      trailing: const Text("---"),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    UKeyValue(
                      leading: UTextBodyMedium("مبلغ کل", color: theme.disabledColor),
                      trailing: const Text("---"),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    UKeyValue(
                      leading: UTextBodyMedium("تعداد اقساط", color: theme.disabledColor),
                      trailing: const Text("---"),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    UKeyValue(
                      leading: UTextBodyMedium("قسط اول", color: theme.disabledColor),
                      trailing: const Text("---"),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    UKeyValue(
                      leading: UTextBodyMedium("بدهی اقساط", color: theme.disabledColor),
                      trailing: const Text("---"),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    const UTextBodySmall("vgcfyhujbhvgcfyuhjbvghjbv"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
