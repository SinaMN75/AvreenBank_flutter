import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class ProfileSelectorTile extends StatelessWidget {
  const ProfileSelectorTile({
    required this.badge,
    required this.name,
    required this.color,
    this.onProfileChange,
    super.key,
  });

  final String badge;
  final String name;
  final VoidCallback? onProfileChange;
  final Color color;

  @override
  Widget build(BuildContext context) => UContainer(
    onTap: () => UNavigator.bottomSheet<void>(
      ProfileSheet(
        profiles: Core.fileInfo.value.fileInfoList,
        activeId: Core.currentFile.value.fileId,
        onSelect: (FileInfo profile) {
          Core.currentFile(profile);
          onProfileChange?.call();
          UNavigator.back();
        },
      ),
    ),
    color: color.withValues(alpha: 0.10),
    radius: 14,
    border: Border.all(color: color.withValues(alpha: 0.22)),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    child: Row(
      children: <Widget>[
        ULetterBadge(badge, background: color.withValues(alpha: 0.18), foreground: color, size: 30, radius: 9),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UTextLabelSmall(U.s.activeProfile, color: color.withValues(alpha: 0.65)),
              UTextBodySmall(name, color: color, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        const SizedBox(width: 8),
        UTextLabelSmall(U.s.change, color: color.withValues(alpha: 0.80)),
      ],
    ),
  );
}

class ProfileSheet extends StatelessWidget {
  const ProfileSheet({required this.profiles, required this.activeId, required this.onSelect, super.key});

  final List<FileInfo> profiles;
  final String? activeId;
  final ValueChanged<FileInfo> onSelect;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return UContainer(
      color: scheme.surface,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: UContainer(width: 38, height: 4, radius: 2, color: scheme.outlineVariant)),
          const SizedBox(height: 15),
          UTextTitleLarge(U.s.selectProfile, fontWeight: FontWeight.bold),
          const SizedBox(height: 14),
          ...profiles.map(
            (FileInfo profile) {
              final bool selected = profile.fileId == activeId;
              return UContainer(
                border: selected ? BoxBorder.all(color: scheme.primary) : BoxBorder.all(color: scheme.outlineVariant),
                color: selected ? scheme.primary.withValues(alpha: 0.08) : scheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 6),
                radius: 16,
                child: ListTile(
                  leading: ULetterBadge(profile.organizationName, background: scheme.primary.withValues(alpha: 0.12), foreground: scheme.primary),
                  title: UTextBodyMedium(profile.organizationName, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: UTextLabelSmall(profile.fileTitle, color: scheme.onSurfaceVariant),
                  trailing: UTextLabelSmall(selected ? "در حال استفاده" : "انتخاب", color: scheme.primary),
                  onTap: () => onSelect(profile),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
