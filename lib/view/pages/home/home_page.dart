import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/fara_balance/fara_balance_page.dart";
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
      return RefreshIndicator.adaptive(
        onRefresh: c.refreshFileInfo,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            ProfileSelectorHeader(onProfileChanged: () {}),
            _accountsSection(context).pSymmetric(horizontal: 16, vertical: 20),
          ],
        ),
      );
    }),
  );

  Widget _accountsSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      UListTile(
        icon: Icons.shopping_basket_outlined,
        title: U.s.kalabargBalanceInquiry,
        trailingIcon: Icons.arrow_forward_ios_rounded,
        color: scheme.primary,
        onTap: () => Core.fileInfo.value.hasExternalNid ? UNavigator.push(const FaraBalancePage()) : UToast.errorToast(message: "کالابرگ برای کد ملی شما ثبت نشده است."),
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
