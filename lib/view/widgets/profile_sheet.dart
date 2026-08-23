import "package:avreen_bank/model/profile_model.dart";
import "package:avreen_bank/view/widgets/letter_badge.dart";
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
            (ProfileModel profile) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _row(context, profile),
            ),
          ),
          const SizedBox(height: 6),
          UButton(
            title: U.s.close,
            type: UButtonType.outlined,
            width: double.infinity,
            onTap: UNavigator.back,
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, ProfileModel profile) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool selected = profile.id == activeId;
    return UContainer(
      color: selected ? scheme.primary.withValues(alpha: 0.08) : scheme.surface,
      radius: 17,
      border: Border.all(color: selected ? scheme.primary : scheme.outlineVariant),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: <Widget>[
          LetterBadge(profile.badge, background: scheme.primary.withValues(alpha: 0.12), foreground: scheme.primary),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UTextBodyMedium(profile.name, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                UTextLabelSmall(profile.meta, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          if (selected) Icon(Icons.check_circle, color: scheme.primary, size: 20),
        ],
      ),
    ).onTap(() => onSelect(profile));
  }
}
