import "package:avreen_bank/model/profile_model.dart";
import "package:avreen_bank/model/quick_action.dart";
import "package:avreen_bank/model/transaction_model.dart";
import "package:avreen_bank/utils/money_extension.dart";
import "package:avreen_bank/view/pages/home/home_controller.dart";
import "package:avreen_bank/view/widgets/account_card.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:avreen_bank/view/widgets/profile_sheet.dart";
import "package:avreen_bank/view/widgets/quick_action_button.dart";
import "package:avreen_bank/view/widgets/section_header.dart";
import "package:avreen_bank/view/widgets/transaction_filter_bar.dart";
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
    return UContainer(
      padding: EdgeInsets.fromLTRB(20, context.padding.top + 16, 20, 24),
      color: scheme.primary,
      radius: 26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ProfileSelectorTile(
            badge: profile?.badge ?? "",
            name: profile?.name ?? "",
            onTap: () => _openProfileSheet(context),
          ),
          _balanceBlock(scheme).pSymmetric(vertical: 12),
          _quickActions().pSymmetric(vertical: 12),
        ],
      ),
    );
  }

  Widget _balanceBlock(ColorScheme scheme) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          UTextBodySmall(U.s.totalBalance, color: scheme.onPrimary.withValues(alpha: 0.70)),
          _eyeToggle(scheme),
        ],
      ),
      const SizedBox(height: 6),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          UTextDisplayMedium(c.balanceHidden.value ? "••••••••" : c.totalBalance.money, color: scheme.onPrimary, fontWeight: FontWeight.bold),
          const SizedBox(width: 6),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: UTextBodySmall(U.s.toman, color: scheme.onPrimary.withValues(alpha: 0.72)),
          ),
        ],
      ),
    ],
  );

  Widget _eyeToggle(ColorScheme scheme) {
    final bool hidden = c.balanceHidden.value;
    return UContainer(
      color: scheme.onPrimary.withValues(alpha: 0.10),
      radius: 10,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 15, color: scheme.onPrimary),
          const SizedBox(width: 6),
          UTextLabelSmall(hidden ? U.s.show : U.s.hide, color: scheme.onPrimary),
        ],
      ),
    ).onTap(c.toggleBalance);
  }

  Widget _quickActions() {
    final List<QuickAction> actions = <QuickAction>[
      QuickAction(icon: Icons.swap_horiz, label: U.s.transferFunds, onTap: () {}),
      QuickAction(icon: Icons.receipt_long_outlined, label: U.s.billPayment, onTap: () {}),
      QuickAction(icon: Icons.description_outlined, label: U.s.statement, onTap: () {}),
      QuickAction(icon: Icons.smartphone_outlined, label: U.s.chargeAndPackage, onTap: () {}),
    ];
    return Row(
      children: actions
          .map(
            (QuickAction action) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: QuickActionButton(action),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _accountsSection(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionHeader(
          title: U.s.accountsInThisProfile,
          trailing: UTextLabelSmall(
            c.accounts.isEmpty ? U.s.emptyLabel : "${c.accounts.length.toString().toPersianNumber()} ${U.s.accountsWord}",
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        if (c.accounts.isEmpty)
          UEmptyState(title: U.s.noAccountsInThisProfile)
        else
          Column(
            children: List<Widget>.generate(
              c.accounts.length,
              (int index) => Padding(
                padding: EdgeInsets.only(bottom: index == c.accounts.length - 1 ? 0 : 9),
                child: AccountCard(c.accounts[index], balanceHidden: c.balanceHidden.value),
              ),
            ),
          ),
      ],
    );
  }

  Widget _transactionsSection(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<TransactionModel> items = c.visibleTransactions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionHeader(
          title: U.s.recentTransactions,
          trailing: TransactionFilterBar(selected: c.filter.value, onChanged: c.setFilter),
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
            child: Column(
              children: List<Widget>.generate(
                items.length,
                (int index) => TransactionTile(items[index], showDivider: index != items.length - 1),
              ),
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
