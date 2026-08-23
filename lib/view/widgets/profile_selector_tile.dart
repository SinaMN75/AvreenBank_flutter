import "package:avreen_bank/view/widgets/letter_badge.dart";
import "package:u/utilities.dart";

class ProfileSelectorTile extends StatelessWidget {
  const ProfileSelectorTile({required this.badge, required this.name, required this.onTap, super.key});

  final String badge;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    return UContainer(
      color: onPrimary.withValues(alpha: 0.10),
      radius: 14,
      border: Border.all(color: onPrimary.withValues(alpha: 0.22)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: <Widget>[
          LetterBadge(badge, background: onPrimary.withValues(alpha: 0.18), foreground: onPrimary, size: 30, radius: 9),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UTextLabelSmall(U.s.activeProfile, color: onPrimary.withValues(alpha: 0.65)),
                UTextBodySmall(name, color: onPrimary, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          UTextLabelSmall(U.s.change, color: onPrimary.withValues(alpha: 0.80)),
          Icon(Icons.keyboard_arrow_down, color: onPrimary.withValues(alpha: 0.80), size: 18),
        ],
      ),
    ).onTap(onTap);
  }
}
