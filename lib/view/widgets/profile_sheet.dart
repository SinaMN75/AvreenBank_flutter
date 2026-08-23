import "package:avreen_bank/model/profile_model.dart";
import "package:u/utilities.dart";

class ProfileSheet extends StatelessWidget {
  const ProfileSheet({required this.profiles, required this.activeId, required this.onSelect, super.key});

  final List<ProfileModel> profiles;
  final String? activeId;
  final ValueChanged<ProfileModel> onSelect;

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
            (ProfileModel profile) {
              final bool selected = profile.id == activeId;
              return ListTile(
                leading: ULetterBadge(profile.badge, background: scheme.primary.withValues(alpha: 0.12), foreground: scheme.primary),
                title: UTextBodyMedium(profile.name, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: UTextLabelSmall(profile.meta, color: scheme.onSurfaceVariant),
                trailing: selected ? Icon(Icons.check_circle, color: scheme.primary, size: 20) : null,
                onTap: () => onSelect(profile),
              ).container(
                borderColor: selected ? scheme.primary : scheme.outlineVariant,
                backgroundColor: selected ? scheme.primary.withValues(alpha: 0.08) : scheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 6),
                radius: 16,
              );
            },
          ),
        ],
      ),
    );
  }
}
