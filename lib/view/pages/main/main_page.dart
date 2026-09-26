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
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: scheme.outlineVariant))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: scheme.surface,
            elevation: 0,
            selectedItemColor: scheme.primary,
            unselectedItemColor: scheme.onSurfaceVariant,
            selectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            currentIndex: selectedIndex.value,
            onTap: (int index) {
              selectedIndex(index);
              pageController.jumpToPage(index);
            },
            items: <BottomNavigationBarItem>[
              _item(Icons.home_outlined, U.s.accounts),
              _item(Icons.credit_card_outlined, U.s.cards),
              _item(Icons.bookmark_border_rounded, "اقساط"),
              _item(Icons.person_outline_rounded, U.s.profile),
            ],
          ),
        ),
      );
    },
  );

  BottomNavigationBarItem _item(IconData icon, String label) => BottomNavigationBarItem(
    icon: Icon(icon).pOnly(bottom: 4),
    label: label,
  );
}
