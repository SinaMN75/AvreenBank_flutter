import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_controller.dart";
import "package:avreen_bank/view/widgets/app_numeric_keyboard.dart";
import "package:u/utilities.dart";

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({required this.nationalCode, required this.preRegisterResponse, super.key});

  final PreRegisterResponse preRegisterResponse;
  final String nationalCode;

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends UState<LoginOtpPage> {
  final LoginOtpController c = LoginOtpController();

  @override
  void initState() {
    c.init(preRegisterResponse: widget.preRegisterResponse, nationalCode: widget.nationalCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => UScaffold(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: <Color>[Color.lerp(theme.scaffoldBackgroundColor, AppColors.success, 0.08)!, theme.scaffoldBackgroundColor],
      ),
    ),
    body: Form(
      key: c.formKey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 14,
            children: <Widget>[
              UContainer(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                shape: BoxShape.circle,
                color: scheme.surface,
                boxShadow: <BoxShadow>[BoxShadow(color: scheme.onSurface.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 3))],
                onTap: UNavigator.back,
                child: Icon(Icons.edit_outlined, color: scheme.primary, size: 18),
              ),
              UTextTitleLarge(widget.nationalCode.toPersianNumber(), fontWeight: FontWeight.bold, textDirection: TextDirection.ltr),
            ],
          ),
          UTextBodyMedium("کد فعال‌سازی به شماره شما ارسال شد.", color: scheme.onSurfaceVariant, maxLines: 2, margin: const EdgeInsets.only(top: 10, bottom: 28)),
          UOtpField(
            length: widget.preRegisterResponse.otpLength,
            controller: c.controllerOtp,
            keyboardMode: UOtpKeyboardMode.external,
            expand: false,
            fieldWidth: 46,
            fieldHeight: 58,
            spacing: 10,
            borderRadius: 12,
            borderWidth: 1.5,
            showCursor: false,
            fillColor: scheme.surface,
            filledBorderColor: scheme.primary,
            activeColor: Color.lerp(scheme.primary, scheme.onSurface, 0.35),
            activeBoxShadow: <BoxShadow>[BoxShadow(color: scheme.primary.withValues(alpha: 0.15), blurRadius: 8, spreadRadius: 2)],
            textStyle: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            characterFormatter: (String character) => character.toPersianNumber(),
            onCompleted: (String _) => c.submit(),
          ),
          Row(
            spacing: 12,
            children: <Widget>[
              UButton(
                expanded: 1,
                height: 50,
                type: UButtonType.outlined,
                title: U.s.resend,
                counter: 60,
                counterResetCounterOnTap: true,
                onTap: c.sendAgain,
                borderRadius: 25,
                borderColor: scheme.primary.withValues(alpha: 0.25),
                backgroundColor: scheme.primary.withValues(alpha: 0.07),
                disabledBackgroundColor: scheme.primary.withValues(alpha: 0.07),
                foregroundColor: scheme.primary,
                disabledForegroundColor: Color.lerp(scheme.primary, scheme.onSurface, 0.35),
                textStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: c.controllerOtp,
                builder: (BuildContext context, TextEditingValue value, Widget? _) {
                  final bool complete = value.text.length == widget.preRegisterResponse.otpLength;
                  return UButton(
                    expanded: 1,
                    height: 50,
                    elevation: 0,
                    title: U.s.confirmAndContinue,
                    enabled: complete,
                    onTap: c.submit,
                    borderRadius: 25,
                    borderColor: complete ? scheme.primary : scheme.onSurfaceVariant.withValues(alpha: 0.3),
                    backgroundColor: scheme.primary,
                    disabledBackgroundColor: AppColors.disabled,
                    foregroundColor: scheme.onPrimary,
                    disabledForegroundColor: scheme.onPrimary,
                    textStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 17, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ).pOnly(top: 24),
          UTextBodyMedium(
            "شرایط استفاده از حکمت نو",
            color: scheme.primary,
            fontWeight: FontWeight.w600,
            margin: const EdgeInsets.only(top: 20),
            onTap: () => UToast.snackBar(message: U.s.comingSoon),
          ),
          const Spacer(),
          AppNumericKeyboard(controller: c.controllerOtp, maxLength: widget.preRegisterResponse.otpLength),
        ],
      ),
    ),
  );
}
