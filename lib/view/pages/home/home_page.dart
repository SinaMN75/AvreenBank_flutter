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
          _accountsSection(context).pAll(16),
        ],
      );
    }),
  );

  Widget _accountsSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      UKeyValue(
        leading: UTextTitleMedium(U.s.accountsInThisProfile),
        trailing: UTextLabelSmall(c.accounts.isEmpty ? U.s.empty : "${c.accounts.length} ${U.s.account}"),
      ),
      const SizedBox(height: 12),
      if (c.accounts.isEmpty)
        UEmptyState(title: U.s.noAccountsInThisProfile)
      else
        Column(
          spacing: 12,
          children: c.accounts.map((AccountInfo i) => AccountCard(account: i)).toList(),
        ),
    ],
  );
}
