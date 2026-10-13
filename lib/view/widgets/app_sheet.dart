import "package:u/utilities.dart";

class AppSheet extends StatelessWidget {
  const AppSheet({
    required this.title,
    required this.children,
    required this.scrollable,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final bool scrollable;

  static Future<T?> show<T>({
    required String title,
    required List<Widget> children,
    bool scrollable = true,
  }) {
    if (scrollable)
      return UNavigator.draggableSheet<T>(
        AppSheet(title: title, scrollable: scrollable, children: children),
        initialChildSize: 0.8,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      );
    else
      return UNavigator.bottomSheet<T>(
        AppSheet(title: title, scrollable: scrollable, children: children),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      );
  }

  @override
  Widget build(BuildContext context) => UColumn(
    scrollable: scrollable ? Axis.vertical : null,
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: 12,
    children: <Widget>[
      URow(
        padding: const EdgeInsets.only(bottom: 4),
        children: <Widget>[
          UTextTitleLarge(title, fontWeight: FontWeight.bold, expanded: 1),
          UTextBodyMedium(U.s.close, color: context.colorScheme.primary, fontWeight: FontWeight.w600, onTap: UNavigator.back),
        ],
      ),
      ...children,
    ],
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
