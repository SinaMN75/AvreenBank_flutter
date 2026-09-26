import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_controller.dart";
import "package:avreen_bank/view/widgets/app_numeric_keyboard.dart";
import "package:u/utilities.dart";

class LoginNationalCodePage extends StatefulWidget {
  const LoginNationalCodePage({super.key});

  @override
  State<LoginNationalCodePage> createState() => _LoginNationalCodePageState();
}

class _LoginNationalCodePageState extends UState<LoginNationalCodePage> {
  final LoginNationalcodeController c = LoginNationalcodeController();

  @override
  Widget build(BuildContext context) => UScaffold(
    color: scheme.surface,
    padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
    body: Form(
      key: c.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const UTextHeadlineSmall("ورود به حساب کاربری", textAlign: TextAlign.center),
          UTextBodyMedium(
            "کد ملی خود را وارد کنید. رمز یک‌بارمصرف به شماره موبایلی که ثبت کرده‌اید فرستاده می‌شود.",
            textAlign: TextAlign.center,
            color: scheme.onSurfaceVariant,
            height: 2,
            maxLines: 3,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 36),
          ),
          UTextField(
            readOnly: true,
            controller: c.controllerNationalCode,
            labelText: U.s.nationalCode,
            validator: UValidators.iranianNationalCode(),
            maxLength: 10,
            borderRadius: 28,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            fontSize: 20,
          ),
          const Spacer(),
          AppNumericKeyboard(
            controller: c.controllerNationalCode,
            maxLength: 10,
            extraKey: "0000",
            actions: <UNumericKeyboardAction>[UNumericKeyboardAction(label: "دریافت کد تأیید", onTap: c.submit, fontSize: 16)],
          ),
        ],
      ),
    ),
  );
}
