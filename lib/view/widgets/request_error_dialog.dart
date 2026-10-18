import "package:avreen_bank/view/widgets/app_sheet.dart";
import "package:u/utilities.dart";

class TooManyRequestsDialog extends StatefulWidget {
  const TooManyRequestsDialog({super.key});

  static const Duration duration = Duration(seconds: 3);
  static bool _isOpen = false;

  static Future<void> show() async {
    if (_isOpen) return;
    _isOpen = true;
    await UNavigator.dialog<void>(const TooManyRequestsDialog(), barrierDismissible: false);
    _isOpen = false;
  }

  @override
  State<TooManyRequestsDialog> createState() => _TooManyRequestsDialogState();
}

class _TooManyRequestsDialogState extends State<TooManyRequestsDialog> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(TooManyRequestsDialog.duration, () {
      if (mounted) Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: AlertDialog(
      icon: Icon(Icons.hourglass_top_rounded, color: context.colorScheme.primary, size: 40),
      title: UTextTitleMedium(U.s.tooManyRequests, fontWeight: FontWeight.bold, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: <Widget>[
          UTextBodyMedium(U.s.pleaseWaitAFewSecondsAndTryAgain, color: context.colorScheme.onSurfaceVariant, textAlign: TextAlign.center),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1, end: 0),
            duration: TooManyRequestsDialog.duration,
            builder: (BuildContext context, double value, Widget? child) => LinearProgressIndicator(value: value, borderRadius: BorderRadius.circular(8)),
          ),
        ],
      ),
    ),
  );
}

class RequestErrorDialog extends StatelessWidget {
  const RequestErrorDialog({required this.page, required this.request, required this.message, super.key});

  final String page;
  final String request;
  final String message;

  static Future<void> show({required String page, required String request, required String message}) => UNavigator.dialog<void>(
    RequestErrorDialog(page: page, request: request, message: message),
    barrierDismissible: false,
  );

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: AlertDialog(
      icon: Icon(Icons.error_outline_rounded, color: context.colorScheme.error, size: 40),
      title: UTextTitleMedium(U.s.requestFailed, fontWeight: FontWeight.bold, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: <Widget>[
          UTextBodyMedium(message, color: context.colorScheme.onSurfaceVariant, textAlign: TextAlign.center, maxLines: 4),
          SheetInfoBox(label: U.s.page, value: page),
          UButton(title: U.s.confirm, onTap: () => Navigator.of(context).pop(), height: 48, elevation: 0, borderRadius: 16, fullWidth: true),
        ],
      ),
    ),
  );
}
