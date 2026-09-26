import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/home/home_controller.dart";
import "package:avreen_bank/view/widgets/account_card.dart";
import "package:avreen_bank/view/widgets/profile_selector_header.dart";
import "package:u/utilities.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends UState<HomePage> {
  final HomeController c = HomeController();

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: UObx(() {
      if (c.state.isLoading()) return const Center(child: UProgressCircular());
      return UColumn(
        scrollable: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ProfileSelectorHeader(onProfileChanged: () {}),
          _accountsSection(context).pSymmetric(horizontal: 16, vertical: 20),
        ],
      );
    }),
  );

  Widget _accountsSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(
        children: <Widget>[
          UTextTitleMedium(U.s.accountsInThisProfile, fontWeight: FontWeight.bold, expanded: 1),
          UContainer(
            radius: 20,
            color: scheme.surface,
            border: Border.all(color: scheme.outlineVariant),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UTextLabelLarge(
              c.accounts.isEmpty ? U.s.empty : "${c.accounts.length.toString().toPersianNumber()} ${U.s.account}",
              color: scheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      if (c.accounts.isEmpty)
        UEmptyState(title: U.s.noAccountsInThisProfile)
      else
        Column(
          spacing: 14,
          children: c.accounts.map((AccountInfo i) => AccountCard(account: i)).toList(),
        ),
    ],
  );
}
