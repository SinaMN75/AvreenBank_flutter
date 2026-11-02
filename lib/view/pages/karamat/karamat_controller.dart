import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class KaramatController extends UBaseController {
  List<GoodGroup> groups = <GoodGroup>[];

  void init() {
    state.loading();
    read();
  }

  Future<void> read() async {
    await Core.dataSource.getGoodGroupsDetails(
      page: "طرح کرامت",
      p: GoodGroupsDetailsParams(fileId: Core.currentFile.value.fileId),
      onOk: (GoodGroupsDetailsResponse response) {
        groups = response.result;
        if (groups.isEmpty)
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
