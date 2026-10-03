import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/loans/loans_controller.dart";
import "package:u/utilities.dart";

class StatusFacePage extends StatefulWidget {
  const StatusFacePage({super.key});

  @override
  State<StatusFacePage> createState() => _StatusFacePageState();
}

class _StatusFacePageState extends UState<StatusFacePage> {
  final LoansController c = LoansController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    appBar: AppBar(),
    safeArea: false,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
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

  Widget _item({required LoanInfo info}) => UContainer(
    radius: 24,
    color: scheme.surface,
    child: UColumn(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        UTextTitleMedium(info.loanTitle ?? "", textAlign: TextAlign.center, color: scheme.primary, margin: const EdgeInsets.symmetric(vertical: 6)),
        UKeyValue(
          leading: UTextBodyMedium("تاریخ سررسید", color: theme.disabledColor),
          trailing: Text(info.amount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("وضعیت", color: theme.disabledColor),
          trailing: Text(info.installmentCount.toString()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("بدهی اعتباری", color: theme.disabledColor),
          trailing: Text(info.payedAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("مانده بدهی اعتباری", color: theme.disabledColor),
          trailing: Text(info.notPayedAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("بدهی تسهیلاتی", color: theme.disabledColor),
          trailing: Text(info.notPayedDueAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("مانده بدهی تسهیلاتی", color: theme.disabledColor),
          trailing: Text(info.startDate.formatJalaliDateTime()),
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
              onTap: () => showCreditDetails(list: info.installmentsStatus ?? <InstallmentsStatus>[]),
            ),
            const SizedBox(width: 20),
            UButton(
              title: "بدهی تسهیلاتی",
              height: 50,
              elevation: 0,
              borderRadius: 16,
              margin: const EdgeInsets.only(top: 8),
              expanded: 1,
              onTap: () => showLoanDetails(list: info.installmentsStatus ?? <InstallmentsStatus>[]),
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
