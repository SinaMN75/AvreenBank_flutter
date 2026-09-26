import "package:u/utilities.dart";

class AppNumericKeyboard extends StatelessWidget {
  const AppNumericKeyboard({required this.controller, required this.maxLength, this.extraKey, this.actions = const <UNumericKeyboardAction>[], super.key});

  final TextEditingController controller;
  final int maxLength;
  final String? extraKey;
  final List<UNumericKeyboardAction> actions;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    return UNumericKeyboard(
      keyHeight: 56,
      actionHeight: 50,
      spacing: 10,
      runSpacing: 10,
      borderRadius: 14,
      fontSize: 26,
      fontWeight: FontWeight.bold,
      backgroundColor: scheme.surface,
      keyBorderColor: scheme.outlineVariant,
      extraKey: extraKey,
      backspaceChild: UTextBodyLarge(U.s.delete, color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600),
      actions: actions,
      actionsPosition: UNumericKeyboardActionsPosition.bottom,
      onBackspace: controller.dropLastCharacter,
      onBackspaceLongPress: controller.clear,
      onKeyTap: (String value) {
        for (final String digit in value.split("")) controller.appendCharacter(digit, maxLength: maxLength);
      },
    );
  }
}
