import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_otp/login_otp_page.dart";
import "package:u/utilities.dart";

class LoginNationalcodeController extends UBaseController {
  final TextEditingController controllerNationalCode = TextEditingController();
  final TextEditingController controllerMobileNo = TextEditingController();

  final FocusNode focusNode = FocusNode();

  void submit() {
    UValidators.validateForm(
      key: formKey,
      action: () {
        ULoading.show();
        final PreRegisterParams preRegisterParams = PreRegisterParams(
          loginMode: 1,
          nationalId: controllerNationalCode.numString(),
          mobileNo: controllerMobileNo.numString(),
        );
        Core.dataSource.preRegister(
          p: preRegisterParams,
          onOk: (PreRegisterResponse response) async {
            ULoading.dismiss();
            await UNavigator.push(LoginOtpPage(preRegisterResponse: response, preRegisterParams: preRegisterParams));
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
