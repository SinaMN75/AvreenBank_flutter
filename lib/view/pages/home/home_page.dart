import "package:avreen_bank/model/profile_model.dart";
import "package:avreen_bank/model/quick_action.dart";
import "package:avreen_bank/model/transaction_model.dart";
import "package:avreen_bank/view/pages/home/home_controller.dart";
import "package:avreen_bank/view/widgets/account_card.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:avreen_bank/view/widgets/profile_sheet.dart";
import "package:avreen_bank/view/widgets/transaction_tile.dart";
import "package:u/utilities.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController c = HomeController();

  @override
  void initState() {
    c.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Obx(() {
      if (c.state.isLoading()) return const Center(child: UProgressCircular());
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _header(context),
            UColumn(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _accountsSection(context),
                const SizedBox(height: 24),
                _transactionsSection(context),
              ],
            ),
          ],
        ),
      );
    }),
  );

  Widget _header(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final ProfileModel? profile = c.activeProfile.value;
    final double topInset = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(20, topInset + 16, 20, 24),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ProfileSelectorTile(
            badge: profile?.badge ?? "",
            name: profile?.name ?? "",
            onTap: () => _openProfileSheet(context),
          ),
          _balanceBlock(scheme).pSymmetric(vertical: 12),
          _quickActions(),
        ],
      ),
    );
  }

  Widget _balanceBlock(ColorScheme scheme) {
    final bool hidden = c.balanceHidden.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UKeyValue(
          leading: UTextBodySmall(U.s.totalBalance, color: scheme.onPrimary.withValues(alpha: 0.70)),
          trailing: UIconTextHorizontal(
            leading: Icon(hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 15, color: scheme.onPrimary),
            trailing: UTextLabelSmall(hidden ? U.s.show : U.s.hide, color: scheme.onPrimary),
          ).chip(backgroundColor: context.colorScheme.onPrimary.withValues(alpha: 0.10)).onTapInk(c.toggleBalance),
        ),
        const SizedBox(height: 6),
        UIconTextHorizontal(
          leading: UTextDisplayMedium(c.balanceHidden.value ? "••••••••" : c.totalBalance.separate3By3(), color: scheme.onPrimary, fontWeight: FontWeight.bold),
          trailing: UTextBodySmall(U.s.toman, color: scheme.onPrimary.withValues(alpha: 0.72)),
        ),
      ],
    );
  }

  Widget _quickActions() {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<QuickAction> actions = <QuickAction>[
      QuickAction(icon: Icons.description_outlined, label: U.s.statement, onTap: () {}),
      QuickAction(icon: Icons.smartphone_outlined, label: U.s.chargeAndPackage, onTap: () {}),
    ];
    return Row(
      children: actions
          .map(
            (QuickAction action) => UIconTextVertical(
              leading: Icon(action.icon, color: scheme.onPrimary),
              trailing: UTextBodySmall(action.label, color: scheme.onPrimary),
            ).chip(backgroundColor: scheme.onPrimary.withValues(alpha: 0.10), margin: const EdgeInsets.symmetric(horizontal: 8)).onTap(action.onTap).expanded(),
          )
          .toList(),
    );
  }

  Widget _accountsSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      UKeyValue(
        leading: UTextTitleMedium(U.s.accountsInThisProfile),
        trailing: UTextLabelSmall(c.accounts.isEmpty ? U.s.emptyLabel : "${c.accounts.length} ${U.s.accountsWord}"),
      ),
      const SizedBox(height: 12),
      if (c.accounts.isEmpty)
        UEmptyState(title: U.s.noAccountsInThisProfile)
      else
        Column(
          children: List<Widget>.generate(
            c.accounts.length,
            (int index) => AccountCard(c.accounts[index], balanceHidden: c.balanceHidden.value).pSymmetric(vertical: 2),
          ),
        ),
    ],
  );

  Widget _transactionsSection(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<TransactionModel> items = c.visibleTransactions;
    final Map<TransactionFilter, String> filterLabels = <TransactionFilter, String>{
      TransactionFilter.all: U.s.all,
      TransactionFilter.credit: U.s.credit,
      TransactionFilter.debit: U.s.debit,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UKeyValue(
          leading: Text(U.s.recentTransactions),
          trailing: UChipChoice<TransactionFilter>(
            options: filterLabels.keys.toList(),
            selected: c.filter.value,
            spacing: 6,
            onChanged: (int index, bool isSelected, TransactionFilter item) => c.setFilter(item),
            chipBuilder: (TransactionFilter item, bool isSelected, int index) => UContainer(
              color: isSelected ? scheme.primary : scheme.surface,
              radius: 9,
              border: Border.all(color: isSelected ? scheme.primary : scheme.outlineVariant),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: UTextLabelSmall(filterLabels[item]!, color: isSelected ? scheme.onPrimary : scheme.onSurfaceVariant),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          UEmptyState(title: U.s.noTransactions)
        else
          UContainer(
            clipBehavior: Clip.hardEdge,
            color: scheme.surface,
            radius: 18,
            border: Border.all(color: scheme.outlineVariant),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext _, int index) => TransactionTile(items[index], showDivider: index != items.length - 1),
              separatorBuilder: (BuildContext _, int _) => const Divider(),
              itemCount: items.length,
            ),
          ),
      ],
    );
  }

  void _openProfileSheet(BuildContext context) => UNavigator.bottomSheet<void>(
    ProfileSheet(
      profiles: c.profiles,
      activeId: c.activeProfile.value?.id,
      onSelect: (ProfileModel profile) {
        c.selectProfile(profile);
        UNavigator.back();
      },
    ),
  );
}
