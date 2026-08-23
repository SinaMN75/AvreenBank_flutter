import "package:avreen_bank/model/quick_action.dart";
import "package:u/utilities.dart";

class QuickActionButton extends StatelessWidget {
  const QuickActionButton(this.action, {super.key});

  final QuickAction action;

  @override
  Widget build(BuildContext context) {
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    return UContainer(
      color: onPrimary.withValues(alpha: 0.10),
      radius: 15,
      border: Border.all(color: onPrimary.withValues(alpha: 0.16)),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(action.icon, color: onPrimary, size: 20),
          const SizedBox(height: 6),
          UTextLabelSmall(action.label, color: onPrimary.withValues(alpha: 0.90), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    ).onTap(action.onTap);
  }
}
