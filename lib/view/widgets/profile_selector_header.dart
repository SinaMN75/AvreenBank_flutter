import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:avreen_bank/view/widgets/profile_sheet.dart";
import "package:u/utilities.dart";

class ProfileSelectorHeader extends StatefulWidget {
  const ProfileSelectorHeader({required this.onProfileChanged, super.key});

  final VoidCallback onProfileChanged;

  @override
  State<ProfileSelectorHeader> createState() => _ProfileSelectorHeaderState();
}

class _ProfileSelectorHeaderState extends UState<ProfileSelectorHeader> {
  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 16, 20, 24),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
      ),
      child: UObx(
        () => ProfileSelectorTile(
          badge: Core.currentFile.value.fileTitle.isNotEmpty == true ? Core.currentFile.value.fileTitle[0] : "",
          name: Core.currentFile.value.fileTitle,
          color: context.colorScheme.onPrimary,
          onTap: () => _openProfileSheet(),
        ),
      ),
    );

  void _openProfileSheet() => UNavigator.bottomSheet<void>(
    ProfileSheet(
      profiles: Core.fileInfo.value.fileInfoList,
      activeId: Core.currentFile.value.fileId,
      onSelect: (FileInfo profile) {
        Core.currentFile(profile);
        widget.onProfileChanged();
        UNavigator.back();
      },
    ),
  );
}
