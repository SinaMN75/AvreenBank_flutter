import "package:u/utilities.dart";

class ProfileSelectorTile extends StatelessWidget {
  const ProfileSelectorTile({
    required this.badge,
    required this.name,
    required this.onTap,
    required this.color,
    super.key,
  });

  final String badge;
  final String name;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => UContainer(
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
          Icon(Icons.keyboard_arrow_down, color: color.withValues(alpha: 0.80), size: 18),
        ],
      ),
    ).onTap(onTap);
}
