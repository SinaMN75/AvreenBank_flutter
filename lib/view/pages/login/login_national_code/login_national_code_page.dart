import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_controller.dart";
import "package:avreen_bank/view/widgets/auth_layout.dart";
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
  Widget build(BuildContext context) => Form(
    key: c.formKey,
    child: AuthLayout(
      children: <Widget>[
        const UTextHeadlineSmall("ورود به حساب کاربری", textAlign: TextAlign.center, margin: EdgeInsets.only(top: 12)),
        UTextBodyMedium(
          "کد ملی و شماره موبایل خود را وارد کنید. رمز یک‌بارمصرف با پیامک ارسال می‌شود.",
          textAlign: TextAlign.center,
          color: scheme.onSurfaceVariant,
          maxLines: 3,
          margin: const EdgeInsets.all(12),
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
          validator: UValidators.iranianPhone(),
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
          height: 52,
          borderRadius: 16,
          elevation: 0,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          boxShadow: <BoxShadow>[BoxShadow(color: scheme.primary.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6))],
          textStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 17, fontWeight: FontWeight.bold),
          margin: const EdgeInsets.only(top: 14),
        ),
      ],
    ),
  );
}
