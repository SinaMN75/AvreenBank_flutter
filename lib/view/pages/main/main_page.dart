import "package:avreen_bank/view/pages/cards/cards_page.dart";
import "package:avreen_bank/view/pages/home/home_page.dart";
import "package:avreen_bank/view/pages/loans/loans_page.dart";
import "package:avreen_bank/view/pages/profile/profile_page.dart";
import "package:u/utilities.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pageController = PageController();
  final URxInt selectedIndex = 0.obs;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UObx(
    () {
      final ColorScheme scheme = context.colorScheme;
      return UScaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int index) => selectedIndex(index),
          children: const <Widget>[
            HomePage(),
            CardsPage(),
            LoansPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: scheme.surface,
          elevation: 0,
          selectedItemColor: scheme.primary,
          unselectedItemColor: scheme.onSurfaceVariant,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: selectedIndex.value,
          onTap: (int index) {
            selectedIndex(index);
            pageController.jumpToPage(index);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_outlined, color: scheme.onSurfaceVariant),
              activeIcon: Icon(Icons.account_balance, color: scheme.primary),
              label: U.s.accounts,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined, color: scheme.onSurfaceVariant),
              activeIcon: Icon(Icons.credit_card, color: scheme.primary),
              label: U.s.cards,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined, color: scheme.onSurfaceVariant),
              activeIcon: Icon(Icons.credit_card, color: scheme.primary),
              label: "اقساط",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: scheme.onSurfaceVariant),
              activeIcon: Icon(Icons.person, color: scheme.primary),
              label: U.s.profile,
            ),
          ],
        ),
      );
    },
  );
}
