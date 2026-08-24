import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_page.dart";
import "package:u/utilities.dart";

class LoginNationalcodeController extends UBaseController {
  final TextEditingController controllerNationalCode = TextEditingController();

  void submit() {
    UValidators.validateForm(
      key: formKey,
      action: () {
        ULoading.show();
        Core.dataSource.preRegister(
          p: PreRegisterParams(loginMode: 1, nationalId: controllerNationalCode.numString()),
          onOk: (PreRegisterResponse response) {
            ULoading.dismiss();
            UNavigator.push(LoginOtpPage(preRegisterResponse: response));
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
      },
    );
  }
}
