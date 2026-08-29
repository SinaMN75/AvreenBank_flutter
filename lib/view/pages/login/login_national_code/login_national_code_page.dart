import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_controller.dart";
import "package:u/utilities.dart";

class LoginNationalCodePage extends StatefulWidget {
  const LoginNationalCodePage({super.key});

  @override
  State<LoginNationalCodePage> createState() => _LoginNationalCodePageState();
}

class _LoginNationalCodePageState extends State<LoginNationalCodePage> {
  final LoginNationalcodeController c = LoginNationalcodeController();

  @override
  Widget build(BuildContext context) => UScaffold(
    padding: const EdgeInsets.all(20),
    body: Form(
      key: c.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ListTile(
            dense: true,
            leading: UImage(AppImages.avreen, borderRadius: 8),
            title: Text("ورود به حساب کاربری"),
            subtitle: Text("کد ملی خود را وارد کنید. رمز یکبارمصرف به شمارهٔ موبایل ثبت‌شده به نامتان پیامک می‌شود."),
          ),
          const Spacer(),
          UTextField(
            readOnly: true,
            controller: c.controllerNationalCode,
            labelText: U.s.nationalCode,
            validator: UValidators.iranianNationalCode(),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            fontSize: 18,
          ),
          const Spacer(),
          UNumericKeyboard(
            fontSize: 32,
            actionsPosition: UNumericKeyboardActionsPosition.bottom,
            actions: <UNumericKeyboardAction>[UNumericKeyboardAction(label: "دریافت کد تایید", onTap: c.submit)],
            onBackspace: () => c.controllerNationalCode.dropLastCharacter(),
            onBackspaceLongPress: () => c.controllerNationalCode.clear(),
            onKeyTap: (String value) => c.controllerNationalCode.appendCharacter(value, maxLength: 11),
          ),
        ],
      ),
    ),
  );
}
