import "package:avreen_bank/data/data.dart";
import "package:u/utilities.dart";

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
          const SizedBox(height: 5),
          UTextBodySmall(U.s.profilesHint, color: scheme.onSurfaceVariant),
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
                  trailing: selected ? Icon(Icons.check_circle, color: scheme.primary, size: 20) : null,
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
