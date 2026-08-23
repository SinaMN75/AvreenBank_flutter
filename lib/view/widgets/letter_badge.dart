import "package:u/utilities.dart";

class LetterBadge extends StatelessWidget {
  const LetterBadge(
    this.label, {
    required this.background,
    required this.foreground,
    this.size = 34,
    this.radius = 11,
    super.key,
  });

  final String label;
  final Color background;
  final Color foreground;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) => UContainer(
    width: size,
    height: size,
    radius: radius,
    color: background,
    alignment: Alignment.center,
    child: UTextLabelLarge(label, color: foreground, fontWeight: FontWeight.bold),
  );
}
