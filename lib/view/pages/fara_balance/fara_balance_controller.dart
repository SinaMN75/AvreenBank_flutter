import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class FaraBalanceController extends UBaseController {
  FaraBalanceResponse? faraBalance;

  void init() {
    state.loading();
    read();
  }

  Future<void> read() async {
    await Core.dataSource.faraBalance(
      page: U.s.itemBalance(U.s.kalabarg),
      onOk: (FaraBalanceResponse response) {
        faraBalance = response;
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
