import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/splash/splash_page.dart";
import "package:u/utilities.dart";

class LoginOtpController extends UBaseController {
  late PreRegisterResponse preRegisterResponse;

  final TextEditingController controllerOtp = TextEditingController();

  void init({required PreRegisterResponse preRegisterResponse}) {
    this.preRegisterResponse = preRegisterResponse;
  }

  void submit() {
    if (controllerOtp.numString().length != preRegisterResponse.otpLength) {
      UToast.errorToast(message: U.s.otpIsInvalid);
      return;
    }
    ULoading.show();
    Core.dataSource.register(
      p: RegisterParams(
        otp: controllerOtp.text,
        personId: preRegisterResponse.personId,
      ),
      onOk: (RegisterResponse response) {
        ULoading.dismiss();
        UNavigator.offAll(const SplashPage());
      },
      onError: (ErrorResponse response) {
        ULoading.dismiss();
        UToast.errorToast(message: response.errorMessage);
      },
      onException: (String response) {
        ULoading.dismiss();
        UToast.errorToast(message: response);
      },
    );
  }
}
