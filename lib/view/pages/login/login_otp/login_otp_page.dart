import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_controller.dart";
import "package:u/utilities.dart";

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({required this.preRegisterResponse, super.key});

  final PreRegisterResponse preRegisterResponse;

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final LoginOtpController c = LoginOtpController();

  @override
  void initState() {
    c.init(preRegisterResponse: widget.preRegisterResponse);
    super.initState();
  }

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
          UOtpField(
            length: widget.preRegisterResponse.otpLength,
            controller: c.controllerOtp,
            keyboardMode: UOtpKeyboardMode.external,
            validator: UValidators.exactLength(length: 6, message: U.s.otpIsInvalid),
            onCompleted: (String _) => c.submit(),
          ),
          const Spacer(),
          UNumericKeyboard(
            actionsPosition: UNumericKeyboardActionsPosition.bottom,
            actions: <UNumericKeyboardAction>[UNumericKeyboardAction(label: "دریافت کد تایید", onTap: c.submit)],
            onBackspace: () => c.controllerOtp.dropLastCharacter(),
            onBackspaceLongPress: () => c.controllerOtp.clear(),
            onKeyTap: (String value) => c.controllerOtp.appendCharacter(value, maxLength: 11),
          ),
        ],
      ),
    ),
  );
}
