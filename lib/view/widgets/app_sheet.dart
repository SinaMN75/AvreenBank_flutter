import "package:u/utilities.dart";

class AppSheet extends StatelessWidget {
  const AppSheet({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  static Future<T?> show<T>({required String title, required List<Widget> children}) => UNavigator.bottomSheet<T>(
    AppSheet(title: title, children: children),
    showDragHandle: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
  );

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: <Widget>[
          Row(
            children: <Widget>[
              UTextTitleLarge(title, fontWeight: FontWeight.bold, expanded: 1),
              UTextBodyMedium(U.s.close, color: context.colorScheme.primary, fontWeight: FontWeight.w600, onTap: UNavigator.back),
            ],
          ).pOnly(bottom: 4),
          ...children,
        ],
      ),
    ),
  );
}

class SheetInfoBox extends StatelessWidget {
  const SheetInfoBox({required this.label, required this.value, this.ltr = false, this.onTap, super.key});

  final String label;
  final String value;
  final bool ltr;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => UContainer(
    radius: 18,
    color: context.colorScheme.onSurface.withValues(alpha: 0.04),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: <Widget>[
        UTextBodySmall(label, color: context.colorScheme.onSurfaceVariant),
        UTextTitleMedium(value, fontWeight: FontWeight.bold, textDirection: ltr ? TextDirection.ltr : null, maxLines: 2),
      ],
    ),
  );
}
