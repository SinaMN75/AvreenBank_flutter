import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_page.dart";
import "package:avreen_bank/view/pages/main/main_page.dart";
import "package:u/utilities.dart";

class SplashController extends UBaseController {
  Future<void> init() async {
    await delay(1000, () {
      if (ULocalStorage.hasToken()) {
        Core.dataSource.getFileInfo(
          onOk: (GetFileInfoResponse response) {
            Core.fileInfo = response.obs;
            Core.currentFile = response.fileInfoList![0].obs;
            UNavigator.offAll(const MainPage());
          },
          onError: (ErrorResponse response) {
            UToast.error(message: response.errorMessage);
          },
          onException: (String response) {
            UToast.error(message: response);
          },
        );
      } else {
        UNavigator.offAll(const LoginNationalCodePage());
      }
    });
  }
}
