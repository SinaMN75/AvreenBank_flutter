import "package:avreen_bank/view/pages/login/otp/login_otp_page.dart";
import "package:u/utilities.dart";

class LoginNationalcodeController extends UBaseController {
  final TextEditingController controllerNationalCode = TextEditingController();

  void submit() {
    UValidators.validateForm(
      key: formKey,
      action: () {
        UNavigator.push(const LoginOtpPage());
      },
    );
  }
}
