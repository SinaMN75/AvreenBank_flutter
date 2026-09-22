import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_page.dart";
import "package:avreen_bank/view/pages/main/main_page.dart";
import "package:u/utilities.dart";

class SplashController extends UBaseController {
  Future<void> init() async {
    if (!ULocalStorage.hasToken()) {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) => UNavigator.offAll(const LoginNationalCodePage()));
      return;
    }
    await Core.dataSource.getFileInfo(
      onOk: (GetFileInfoResponse response) {
        Core.fileInfo = response.obs;
        Core.currentFile = response.fileInfoList[0].obs;
        UNavigator.offAll(const MainPage());
      },
      onError: (ErrorResponse response) async {
        UToast.error(message: response.errorMessage);
        await ULocalStorage.clear();
        await UFileStorage.clear();
        // await UNavigator.offAll(const SplashPage());
      },
      onException: (String response) async {
        UToast.error(message: response);
        await ULocalStorage.clear();
        await UFileStorage.clear();
        // await UNavigator.offAll(const SplashPage());
      },
    );
  }
}
