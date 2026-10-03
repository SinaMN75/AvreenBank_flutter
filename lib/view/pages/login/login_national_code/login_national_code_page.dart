import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_controller.dart";
import "package:u/utilities.dart";

class LoginNationalCodePage extends StatefulWidget {
  const LoginNationalCodePage({super.key});

  @override
  State<LoginNationalCodePage> createState() => _LoginNationalCodePageState();
}

class _LoginNationalCodePageState extends UState<LoginNationalCodePage> {
  final LoginNationalcodeController c = LoginNationalcodeController();

  @override
  void initState() {
    super.initState();
    c.focusNode.requestFocus();
  }

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
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          ),
          UTextField(
            focusNode: c.focusNode,
            controller: c.controllerNationalCode,
            labelText: U.s.nationalCode,
            validator: UValidators.iranianNationalCode(),
            maxLength: 10,
            borderRadius: 28,
            keyboardType: TextInputType.number,
            formatters: <TextInputFormatter>[UNumberInputFormatter()],
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fontSize: 20,
            margin: const EdgeInsets.symmetric(vertical: 6),
          ),
          UTextField(
            controller: c.controllerMobileNo,
            labelText: U.s.mobileNumber,
            validator: UValidators.phone(),
            maxLength: 13,
            borderRadius: 28,
            keyboardType: TextInputType.number,
            formatters: <TextInputFormatter>[UNumberInputFormatter()],
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fontSize: 20,
            margin: const EdgeInsets.symmetric(vertical: 6),
          ),
          UButton(
            title: U.s.getPinViaSms,
            fullWidth: true,
            onTap: c.submit,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    ),
  );
}
