import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/fara_balance/fara_balance_page.dart";
import "package:avreen_bank/view/pages/home/home_controller.dart";
import "package:avreen_bank/view/pages/karamat/karamat_page.dart";
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
            _slider().pOnly(left: 10, right: 10, top: 20),
            _accountsSection(context).pOnly(left: 16, right: 16, bottom: 20),
          ],
        ),
      );
    }),
  );

  Widget _slider() => UCarousel<Widget>(
    height: 90,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 5),
    viewportFraction: 1,
    itemSpacing: 12,
    withIndicator: true,
    items: <Widget>[
      UListTile(
        icon: Icons.shopping_basket_outlined,
        title: U.s.kalabargBalanceInquiry,
        subtitle: "مشاهده موجودی و تعداد اعضای خانوار",
        trailingIcon: Icons.arrow_forward_ios_rounded,
        color: scheme.primary,
        onTap: () => Core.fileInfo.value.hasExternalNid ? UNavigator.push(const FaraBalancePage()) : UToast.errorToast(message: "کالابرگ برای کد ملی شما ثبت نشده است."),
      ),
      UListTile(
        backgroundColor: const Color.fromRGBO(254, 198, 58, 0.3),
        icon: Icons.inventory_2_outlined,
        title: "طرح کرامت امام رضا (ع)",
        subtitle: "تا نوروز با قیمت‌های امروز",
        trailingIcon: Icons.arrow_forward_ios_rounded,
        color: AppColors.success,
        onTap: () => UNavigator.push(const KaramatPage()),
      ),
    ],
    itemBuilder: (BuildContext context, Widget item, int index) => item,
  );

  Widget _accountsSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
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
