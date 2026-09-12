import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_controller.dart";
import "package:u/utilities.dart";

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({required this.nationalCode, required this.preRegisterResponse, super.key});

  final PreRegisterResponse preRegisterResponse;
  final String nationalCode;

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final LoginOtpController c = LoginOtpController();

  @override
  void initState() {
    c.init(preRegisterResponse: widget.preRegisterResponse, nationalCode: widget.nationalCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    appBar: AppBar(
      leadingWidth: 28,
      title: const ListTile(
        dense: true,
        leading: UImage(AppImages.avreen, borderRadius: 8),
        title: Text("ورود به حساب کاربری"),
        subtitle: Text("کد تایید به شماره ثبت شده در سامانه پیامک شد."),
      ),
    ),
    padding: const EdgeInsets.all(20),
    body: Form(
      key: c.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UOtpField(
            length: widget.preRegisterResponse.otpLength,
            controller: c.controllerOtp,
            keyboardMode: UOtpKeyboardMode.external,
            validator: UValidators.exactLength(length: 6, message: U.s.otpIsInvalid),
            onCompleted: (String _) => c.submit(),
          ),
          const Spacer(),
          UContainer(
            constraints: const BoxConstraints(maxWidth: 700),
            child: UNumericKeyboard(
              actionsPosition: UNumericKeyboardActionsPosition.bottom,
              onBackspace: () => c.controllerOtp.dropLastCharacter(),
              onBackspaceLongPress: () => c.controllerOtp.clear(),
              onKeyTap: (String value) => c.controllerOtp.appendCharacter(value, maxLength: 11),
            ),
          ),
          URow(
            margin: const EdgeInsets.symmetric(vertical: 12),
            children: <Widget>[
              UButton(
                expanded: 1,
                height: 60,
                type: UButtonType.text,
                counter: 60,
                onTap: c.sendAgain,
                title: U.s.resend,
                counterResetCounterOnTap: true,
              ),
              UButton(
                expanded: 1,
                height: 60,
                title: U.s.confirmAndContinue,
                onTap: c.submit,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
