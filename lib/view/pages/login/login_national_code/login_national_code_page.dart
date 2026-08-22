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
          const UImage(AppImages.avreen, width: 100, height: 100, borderRadius: 12).pSymmetric(vertical: 12),
          const UTextHeadlineMedium("ورود به حساب کاربری", fontWeight: FontWeight.bold).pSymmetric(vertical: 8),
          const UTextBodyMedium(
            "کد ملی خود را وارد کنید. رمز یکبارمصرف به شمارهٔ موبایل ثبت‌شده به نامتان پیامک می‌شود.",
            maxLines: 2,
          ).pSymmetric(vertical: 8),
          UTextField(
            readOnly: true,
            controller: c.controllerNationalCode,
            labelText: U.s.nationalCode,
            validator: UValidators.iranianNationalCode(),
          ),
          const Spacer(),
          UNumericKeyboard(
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
