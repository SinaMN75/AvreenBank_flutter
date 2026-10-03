import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_page.dart";
import "package:avreen_bank/view/pages/splash/splash_page.dart";
import "package:u/utilities.dart";

class LoginOtpController extends UBaseController {
  late PreRegisterResponse preRegisterResponse;
  late PreRegisterParams preRegisterParams;

  final TextEditingController controllerOtp = TextEditingController();

  void init({
    required PreRegisterResponse preRegisterResponse,
    required PreRegisterParams preRegisterParams,
  }) {
    this.preRegisterResponse = preRegisterResponse;
    this.preRegisterParams = preRegisterParams;
  }

  void sendAgain() {
    ULoading.show();
    Core.dataSource.preRegister(
      p: PreRegisterParams(loginMode: 1, nationalId: preRegisterParams.nationalId, mobileNo: preRegisterParams.mobileNo),
      onOk: (PreRegisterResponse response) async {
        ULoading.dismiss();
        ULocalStorage.set(AppConstants.personId, response.loginToken);
        await UNavigator.off(LoginOtpPage(preRegisterParams: preRegisterParams, preRegisterResponse: response));
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
        loginToken: preRegisterResponse.loginToken,
      ),
      onOk: (RegisterResponse response) {
        ULocalStorage.setToken(response.token!);
        ULocalStorage.set(AppConstants.personId, response.personId);
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
