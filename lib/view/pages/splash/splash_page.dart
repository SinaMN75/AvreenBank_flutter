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
    alignment: Alignment.center,
    body: Column(
      children: <Widget>[
        const Spacer(),
        const UImage(AppImages.logo, width: 200, height: 200),
        const Spacer(),
        UTextBodyMedium("${U.s.version} ${UApp.version}", fontWeight: FontWeight.bold),
        const Spacer(),
      ],
    ),
  );
}
