import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class KaramatTransactionsController extends UBaseController {
  late GoodGroup group;
  List<GoodGroupTransaction> transactions = <GoodGroupTransaction>[];

  void init({required GoodGroup group}) {
    this.group = group;
    state.loading();
    read();
  }

  Future<void> read() async {
    await Core.dataSource.getGoodGroupsTransactions(
      page: "تراکنش‌های طرح کرامت",
      p: GoodGroupsTransactionsParams(fileId: Core.currentFile.value.fileId, groupId: group.groupId ?? ""),
      onOk: (GoodGroupsTransactionsResponse response) {
        transactions = response.result;
        if (transactions.isEmpty)
          state.emptying();
        else
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
