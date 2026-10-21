import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class KalabargController extends UBaseController {
  KalabargBalanceResponse? kalabarg;

  void init() {
    state.loading();
    read();
  }

  Future<void> read() async {
    await Core.dataSource.kalabargBalance(
      page: U.s.kalabargBalance,
      p: KalabargBalanceParams(fileId: Core.currentFile.value.fileId),
      onOk: (KalabargBalanceResponse response) {
        kalabarg = response;
        state.loaded();
      },
      onError: (ErrorResponse response) {
        UToast.errorToast(message: response.errorMessage);
        state.error();
      },
      onException: (String response) {
        state.error();
      },
    );
  }
}
