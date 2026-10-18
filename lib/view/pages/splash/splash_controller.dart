import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/login/login_national_code/login_national_code_page.dart";
import "package:avreen_bank/view/pages/main/main_page.dart";
import "package:u/utilities.dart";

class SplashController extends UBaseController {
  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!ULocalStorage.hasToken()) {
      await UNavigator.offAll(const LoginNationalCodePage());
      return;
    }
    await getFileInfo();
  }

  Future<void> getFileInfo() async {
    state.loading();
    await Core.dataSource.getFileInfo(
      page: U.s.splash,
      onOk: (GetFileInfoResponse response) {
        Core.fileInfo = response.obs;
        Core.currentFile = response.fileInfoList[0].obs;
        UNavigator.offAll(const MainPage());
      },
      onError: (ErrorResponse response) => setError(response.errorMessage),
      onException: (_) => state.error(),
    );
  }
}
