import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_page.dart";
import "package:avreen_bank/view/pages/splash/splash_page.dart";
import "package:u/utilities.dart";

class LoginOtpController extends UBaseController {
  late PreRegisterResponse preRegisterResponse;
  late String nationalCode;

  final TextEditingController controllerOtp = TextEditingController();

  void init({
    required PreRegisterResponse preRegisterResponse,
    required String nationalCode,
  }) {
    this.preRegisterResponse = preRegisterResponse;
    this.nationalCode = nationalCode;
  }

  void sendAgain() {
    ULoading.show();
    Core.dataSource.preRegister(
      p: PreRegisterParams(loginMode: 1, nationalId: nationalCode),
      onOk: (PreRegisterResponse response) {
        ULoading.dismiss();
        UNavigator.off(LoginOtpPage(nationalCode: nationalCode, preRegisterResponse: response));
      },
      onError: (ErrorResponse response) {
        ULoading.dismiss();
        UToast.error(message: response.errorMessage);
      },
      onException: (String response) {
        ULoading.dismiss();
        UToast.error(message: response);
      },
    );
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
        ULocalStorage.setToken(response.token!);
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
