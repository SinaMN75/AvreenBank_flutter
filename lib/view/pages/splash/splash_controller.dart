import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_page.dart";
import "package:u/utilities.dart";

class SplashController extends UBaseController {
  Future<void> init() async {
    await delay(1000, () {
      UNavigator.offAll(const LoginNationalCodePage());
    });
  }
}
