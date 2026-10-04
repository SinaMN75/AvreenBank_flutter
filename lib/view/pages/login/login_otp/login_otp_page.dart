import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_controller.dart";
import "package:avreen_bank/view/widgets/auth_layout.dart";
import "package:u/utilities.dart";

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({required this.preRegisterParams, required this.preRegisterResponse, super.key});

  final PreRegisterResponse preRegisterResponse;
  final PreRegisterParams preRegisterParams;

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends UState<LoginOtpPage> {
  final LoginOtpController c = LoginOtpController();

  @override
  void initState() {
    c.init(preRegisterResponse: widget.preRegisterResponse, preRegisterParams: widget.preRegisterParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: c.formKey,
    child: AuthLayout(
      children: <Widget>[
        const UTextHeadlineSmall("کد تایید را وارد کنید", textAlign: TextAlign.center, margin: EdgeInsets.only(top: 20)),
        UTextBodyMedium(
          "کد فعال‌سازی به شماره زیر ارسال شد.",
          textAlign: TextAlign.center,
          color: scheme.onSurfaceVariant,
          maxLines: 2,
          margin: const EdgeInsets.only(top: 10, bottom: 12),
        ),
        Center(
          child: UContainer(
            radius: 20,
            color: scheme.primary.withValues(alpha: 0.07),
            padding: const EdgeInsets.fromLTRB(12, 6, 16, 6),
            onTap: UNavigator.back,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: <Widget>[
                UTextTitleMedium(widget.preRegisterParams.mobileNo.toPersianNumber(), fontWeight: FontWeight.bold, textDirection: TextDirection.ltr),
                Icon(Icons.edit_outlined, color: scheme.primary, size: 18),
              ],
            ),
          ),
        ),
        UOtpField(
          length: widget.preRegisterResponse.otpLength,
          controller: c.controllerOtp,
          autoFocus: true,
          fieldHeight: 56,
          borderRadius: 14,
          borderWidth: 1.5,
          showCursor: false,
          fillColor: scheme.surface,
          borderColor: scheme.outlineVariant,
          filledBorderColor: scheme.primary,
          activeColor: Color.lerp(scheme.primary, scheme.onSurface, 0.35),
          activeBoxShadow: <BoxShadow>[BoxShadow(color: scheme.primary.withValues(alpha: 0.15), blurRadius: 8, spreadRadius: 2)],
          textStyle: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          characterFormatter: (String character) => character.toPersianNumber(),
          onCompleted: (String _) => c.submit(),
        ).pOnly(top: 24),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: c.controllerOtp,
          builder: (BuildContext context, TextEditingValue value, Widget? _) {
            final bool complete = value.text.length == widget.preRegisterResponse.otpLength;
            return UButton(
              title: U.s.confirmAndContinue,
              fullWidth: true,
              enabled: complete,
              onTap: c.submit,
              height: 52,
              borderRadius: 16,
              elevation: 0,
              backgroundColor: scheme.primary,
              disabledBackgroundColor: AppColors.disabled,
              foregroundColor: scheme.onPrimary,
              disabledForegroundColor: scheme.onPrimary,
              boxShadow: complete ? <BoxShadow>[BoxShadow(color: scheme.primary.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6))] : null,
              textStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 17, fontWeight: FontWeight.bold),
              margin: const EdgeInsets.only(top: 24),
            );
          },
        ),
        UButton(
          type: UButtonType.outlined,
          title: U.s.resend,
          fullWidth: true,
          counter: 60,
          counterResetCounterOnTap: true,
          onTap: c.sendAgain,
          height: 52,
          borderRadius: 16,
          borderColor: scheme.primary.withValues(alpha: 0.25),
          backgroundColor: scheme.primary.withValues(alpha: 0.07),
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.07),
          foregroundColor: scheme.primary,
          disabledForegroundColor: Color.lerp(scheme.primary, scheme.onSurface, 0.35),
          textStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
          margin: const EdgeInsets.only(top: 12),
        ),
        UTextBodyMedium(
          "شرایط استفاده از حکمت نو",
          textAlign: TextAlign.center,
          color: scheme.primary,
          fontWeight: FontWeight.w600,
          margin: const EdgeInsets.only(top: 20),
          onTap: () => UToast.snackBar(message: U.s.comingSoon),
        ),
      ],
    ),
  );
}
