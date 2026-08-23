import "package:u/utilities.dart";

class DynamicPinSheet extends StatefulWidget {
  const DynamicPinSheet({super.key});

  @override
  State<DynamicPinSheet> createState() => _DynamicPinSheetState();
}

class _DynamicPinSheetState extends State<DynamicPinSheet> {
  static const int _total = 60;
  final String _code = (100000 + Random().nextInt(900000)).toString();
  int _seconds = _total;
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_seconds <= 1) {
        timer.cancel();
        if (mounted) setState(() => _seconds = 0);
      } else if (mounted) {
        setState(() => _seconds -= 1);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final bool expired = _seconds == 0;
    return UContainer(
      color: scheme.surface,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: UContainer(width: 38, height: 4, radius: 2, color: scheme.outlineVariant)),
          const SizedBox(height: 15),
          UTextTitleLarge(U.s.dynamicPin, fontWeight: FontWeight.bold),
          const SizedBox(height: 5),
          UTextBodySmall(U.s.dynamicPinHint, color: scheme.onSurfaceVariant),
          const SizedBox(height: 16),
          UContainer(
            color: scheme.surface,
            radius: 18,
            border: Border.all(color: scheme.outlineVariant),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            child: Column(
              children: <Widget>[
                UTextDisplaySmall(
                  expired ? "——————" : _code.toPersianNumber(),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                  color: expired ? scheme.onSurfaceVariant : scheme.onSurface,
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _seconds / _total,
                    minHeight: 4,
                    backgroundColor: scheme.outlineVariant,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                UTextLabelSmall("$_seconds ${U.s.secondsWord}", color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(height: 16),
          UButton(title: U.s.close, width: double.infinity, onTap: UNavigator.back),
        ],
      ),
    );
  }
}
