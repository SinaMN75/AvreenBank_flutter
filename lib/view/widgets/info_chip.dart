import "package:u/utilities.dart";

class InfoChip extends StatelessWidget {
  const InfoChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return UContainer(
      color: scheme.primary.withValues(alpha: 0.08),
      radius: 8,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: UTextLabelSmall(label, color: scheme.onSurfaceVariant),
    );
  }
}
