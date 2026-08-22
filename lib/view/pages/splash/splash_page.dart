import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/splash/splash_controller.dart";
import "package:u/utilities.dart";

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController c = SplashController();

  @override
  void initState() {
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    color: Theme.of(context).colorScheme.scrim,
    alignment: Alignment.center,
    body: UImage(AppImages.logo, width: context.width - 40),
  );
}
