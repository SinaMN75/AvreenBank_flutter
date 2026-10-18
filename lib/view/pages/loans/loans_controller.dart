import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

enum LoanState { all, payed, notPayed, dueDate }

enum PayLoanType { dueDate, notPayed, payAll, custom }

class LoansController extends UBaseController {
  final URxn<FileInfo> activeProfile = URxn<FileInfo>();
  List<LoanInfo> list = <LoanInfo>[];

  URx<PayLoanType> payLoanType = PayLoanType.notPayed.obs;

  void init() {
    read();
  }

  void read() {
    state.loading();
    Core.dataSource.inquiryLoan(
      page: U.s.loans,
      p: InquiryLoanParams(fileId: Core.currentFile.value.fileId),
      onOk: (InquiryLoanResponse response) {
        list = response.loanInfoList;
        if (response.loanInfoList.isEmpty) state.emptying();
        else state.loaded();
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
