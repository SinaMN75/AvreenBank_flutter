import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class AuthLayout extends StatelessWidget {
  const AuthLayout({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return UScaffold(
      safeArea: false,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.lerp(theme.scaffoldBackgroundColor, scheme.primary, 0.04)!,
            Color.lerp(theme.scaffoldBackgroundColor, scheme.primary, 0.10)!,
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: CustomPaint(painter: _AuthArcsPainter(color: scheme.primary))),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                child: UContainer(
                  maxWidth: 460,
                  radius: 32,
                  color: scheme.surface,
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  boxShadow: <BoxShadow>[BoxShadow(color: scheme.primary.withValues(alpha: 0.12), blurRadius: 32, offset: const Offset(0, 12))],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const UImage(AppImages.logo, width: 80, height: 80),
                      ...children,
                      UTextBodyMedium(
                        "حکمت نو",
                        textAlign: TextAlign.center,
                        color: scheme.onSurfaceVariant,
                        margin: const EdgeInsets.only(top: 32),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthArcsPainter extends CustomPainter {
  const _AuthArcsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    canvas.drawCircle(
      Offset(w * 0.05, -w * 0.39),
      w * 0.75,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.045
        ..color = color.withValues(alpha: 0.10),
    );
    canvas.drawCircle(
      Offset(w, h + w * 0.3),
      w * 0.68,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.045
        ..color = color.withValues(alpha: 0.16),
    );
  }

  @override
  bool shouldRepaint(_AuthArcsPainter oldDelegate) => oldDelegate.color != color;
}
