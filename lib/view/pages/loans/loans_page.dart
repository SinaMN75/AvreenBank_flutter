import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/loans/loans_controller.dart";
import "package:avreen_bank/view/widgets/profile_selector_header.dart";
import "package:avreen_bank/view/widgets/statement.dart";
import "package:u/utilities.dart";

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends UState<LoansPage> {
  final LoansController c = LoansController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    body: Column(
      children: <Widget>[
        ProfileSelectorHeader(onProfileChanged: () => c.init()),
        Obx(
          () {
            if (c.state.isEmpty()) {
              return const UEmptyState(title: "خرید اقساطی انجام نداده‌اید").alignAtCenter();
            } else if (c.state.isLoaded())
              return ListView.builder(
                itemCount: c.list.length,
                itemBuilder: (BuildContext context, int index) => _item(info: c.list[index]),
              );
            else
              return const CircularProgressIndicator().alignAtCenter();
          },
        ).expanded(),
      ],
    ),
  );

  Widget _item({required LoanInfo info}) => UCard(
    margin: const EdgeInsets.all(8),
    child: UColumn(
      padding: const EdgeInsets.all(12),
      children: <Widget>[
        UTextTitleMedium(info.loanTitle ?? "", textAlign: TextAlign.center, color: scheme.primary, margin: const EdgeInsets.symmetric(vertical: 6)),
        UKeyValue(
          leading: UTextBodyMedium("مبلغ کل اقساط", color: theme.disabledColor),
          trailing: Text(info.amount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("تعداد اقساط", color: theme.disabledColor),
          trailing: Text(info.installmentCount.toString()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("پرداخت شده کل", color: theme.disabledColor),
          trailing: Text(info.payedAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("باقیمانده کل", color: theme.disabledColor),
          trailing: Text(info.notPayedAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium("مبلغ سررسید شده", color: theme.disabledColor),
          trailing: Text(info.notPayedDueAmount.rial()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium(U.s.startDate, color: theme.disabledColor),
          trailing: Text(info.startDate.formatJalaliDateTime()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UKeyValue(
          leading: UTextBodyMedium(U.s.endDate, color: theme.disabledColor),
          trailing: Text(info.endDate.formatJalaliDateTime()),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        UButton(
          title: U.s.details,
          fullWidth: true,
          onTap: () => showDetails(list: info.installmentsStatus ?? <InstallmentsStatus>[]),
        ),
      ],
    ),
  );

  void showDetails({required List<InstallmentsStatus> list}) {
    final RxList<InstallmentsStatus> filteredList = list.obs;
    final Rx<LoanState> loanState = LoanState.all.obs;
    UNavigator.draggableSheet(
      UColumn(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          USegmentedControl<LoanState>(
            items: <LoanState, String>{
              LoanState.all: U.s.all,
              LoanState.dueDate: U.s.dueDate,
              LoanState.payed: U.s.paid,
              LoanState.notPayed: U.s.unpaid,
            },
            selectedValue: loanState.value,
            onValueChanged: (LoanState? i) {
              if (i == LoanState.all) filteredList(list);
              if (i == LoanState.payed) filteredList(list.where((InstallmentsStatus e) => e.status == "P").toList());
              if (i == LoanState.notPayed) filteredList(list.where((InstallmentsStatus e) => e.status == "N").toList());
              if (i == LoanState.dueDate) filteredList(list.where((InstallmentsStatus e) => e.status == "D").toList());
            },
          ),
          Obx(
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
                    title: UTextBodyMedium(i.statusString(), color: i.statusColor()),
                    subtitle: Text(i.dueDate.toJalaliDateString()),
                    trailing: UIconTextVertical(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      leading: Text("مبلغ کل اقساط${i.amount.rial()}"),
                      trailing: Text("پرداخت شده کل ${i.payAmount.rial()}"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void statementBottomSheet({required LoanInfo info}) {
    final RxState state = RxState();
    late AccountStatementResponse statement;
    Core.dataSource.accountStatement(
      p: AccountStatementParams(accountId: info.loanAccountId ?? "", count: 100),
      onOk: (AccountStatementResponse response) {
        statement = response;
        state.loaded();
      },
      onError: (ErrorResponse response) {
        state.error();
        UToast.error(message: response.errorMessage);
      },
      onException: (String response) {
        state.error();
        UToast.error(message: response);
      },
    );
    UNavigator.draggableSheet(Obx(() => state.isLoaded() ? StatementListView(list: statement.statementElementList).pAll(8) : const SizedBox()));
  }
}
