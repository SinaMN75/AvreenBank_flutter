import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_controller.dart";
import "package:avreen_bank/view/widgets/numeric_keyboard.dart";
import "package:u/utilities.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController c = LoginController();

  @override
  Widget build(BuildContext context) => UScaffold(
    padding: const EdgeInsets.all(20),
    body: Column(
      children: <Widget>[
        const UImage(AppImages.avreen, width: 100, height: 100, borderRadius: 12),
        const UTextHeadlineMedium("ورود به حساب کاربری", fontWeight: FontWeight.bold),
        const UTextBodyMedium("کد ملی خود را وارد کنید. رمز یکبارمصرف به شمارهٔ موبایل ثبت‌شده به نامتان پیامک می‌شود."),
        UTextField(
          readOnly: true,
          controller: c.controllerNationalCode,
          labelText: U.s.nationalCode,
        ),
        const Spacer(),
        UNumericKeyboard(
          actionsPosition: UNumericKeyboardActionsPosition.bottom,
          actions: <UNumericKeyboardAction>[UNumericKeyboardAction(label: "دریافت کد تایید", onTap: c.submit)],
          onBackspace: () {
            // c.controllerNationalCode.dropString()
          },
          onKeyTap: (String value) {
            c.controllerNationalCode.text += value;
          },
        ),
      ],
    ),
  );
}
