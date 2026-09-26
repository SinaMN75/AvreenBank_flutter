import "package:u/utilities.dart";

class DynamicPinSheet extends StatefulWidget {
  const DynamicPinSheet({required this.code, required this.onRefresh, this.validity = 60, super.key});

  final String code;
  final VoidCallback onRefresh;
  final int validity;

  @override
  State<DynamicPinSheet> createState() => _DynamicPinSheetState();
}

class _DynamicPinSheetState extends State<DynamicPinSheet> {
  late final TextEditingController _controller = TextEditingController(text: widget.code);
  late int _seconds = widget.validity;
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_seconds <= 1) timer.cancel();
      if (mounted) setState(() => _seconds -= 1);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: <Widget>[
        UTextBodySmall("این رمز فقط برای همین کارت و تا پایان زمان اعلام‌شده معتبر است.", color: scheme.onSurfaceVariant, textAlign: TextAlign.center, maxLines: 2),
        UOtpField(
          length: widget.code.length,
          controller: _controller,
          readOnly: true,
          fieldHeight: 64,
          spacing: 10,
          borderRadius: 14,
          borderWidth: 1.5,
          filledBorderColor: _seconds == 0 ? scheme.outlineVariant : scheme.primary,
          textStyle: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        UTextBodySmall("$_seconds ${U.s.seconds} تا پایان اعتبار رمز", color: scheme.onSurfaceVariant, textAlign: TextAlign.center),
        UButton(title: "گرفتن رمز تازه", onTap: widget.onRefresh, height: 54, elevation: 0, borderRadius: 16, fullWidth: true),
      ],
    );
  }
}
