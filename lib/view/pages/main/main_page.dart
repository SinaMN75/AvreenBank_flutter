import "package:avreen_bank/view/pages/home/home_page.dart";
import "package:u/utilities.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pageController = PageController();
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) => Obx(
    () {
      final ColorScheme scheme = context.colorScheme;
      return UScaffold(
        body: IndexedStack(
          index: selectedIndex.value,
          children: const <Widget>[
            HomePage(),
            SizedBox(),
            SizedBox(),
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
          onTap: (int index) => selectedIndex(index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_outlined, color: scheme.onSurfaceVariant),
              activeIcon: Icon(Icons.account_balance, color: scheme.primary),
              label: U.s.account,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined, color: scheme.onSurfaceVariant),
              activeIcon: Icon(Icons.credit_card, color: scheme.primary),
              label: "کارت‌ها",
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
