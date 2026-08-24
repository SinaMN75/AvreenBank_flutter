import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_page.dart";
import "package:avreen_bank/view/pages/main/main_page.dart";
import "package:u/utilities.dart";

class SplashController extends UBaseController {
  Future<void> init() async {
    await delay(1000, () {
      if (ULocalStorage.hasToken()) {
        UNavigator.offAll(const MainPage());
      } else {
        UNavigator.offAll(const LoginNationalCodePage());
      }
      UNavigator.offAll(const LoginNationalCodePage());
    });
  }
}
