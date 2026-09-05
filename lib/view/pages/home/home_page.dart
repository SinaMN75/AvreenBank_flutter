import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/home/home_controller.dart";
import "package:avreen_bank/view/widgets/account_card.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:avreen_bank/view/widgets/profile_sheet.dart";
import "package:u/utilities.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends UState<HomePage> {
  final HomeController c = HomeController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    safeArea: false,
    body: Obx(() {
      if (c.state.isLoading()) return const Center(child: UProgressCircular());
      return UColumn(
        scrollable: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _header(context),
          _accountsSection(context).pAll(16),
        ],
      );
    }),
  );

  Widget _header(BuildContext context) {
    final FileInfo? profile = c.activeProfile.value;
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 16, 20, 24),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
      ),
      child: ProfileSelectorTile(
        badge: profile?.fileTitle.isNotEmpty == true ? profile!.fileTitle[0] : "",
        name: profile?.fileTitle ?? "",
        color: context.colorScheme.onPrimary,
        onTap: () => _openProfileSheet(context),
      ),
    );
  }

  Widget _accountsSection(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      UKeyValue(
        leading: UTextTitleMedium(U.s.accountsInThisProfile),
        trailing: UTextLabelSmall(c.accounts.isEmpty ? U.s.empty : "${c.accounts.length} ${U.s.accounts}"),
      ),
      const SizedBox(height: 12),
      if (c.accounts.isEmpty)
        UEmptyState(title: U.s.noAccountsInThisProfile)
      else
        Column(
          children: List<Widget>.generate(
            c.accounts.length,
            (int index) => AccountCard(account: c.accounts[index], balanceHidden: c.balanceHidden.value, index: index).pSymmetric(vertical: 2),
          ),
        ),
    ],
  );

  void _openProfileSheet(BuildContext context) => UNavigator.bottomSheet<void>(
    ProfileSheet(
      profiles: Core.fileInfo.value.fileInfoList,
      activeId: c.activeProfile.value?.fileId,
      onSelect: (FileInfo profile) {
        c.selectProfile(profile);
        UNavigator.back();
      },
    ),
  );
}
