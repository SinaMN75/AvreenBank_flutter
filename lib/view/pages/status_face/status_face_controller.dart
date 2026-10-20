import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

enum CreditStatementDatePreset {
  thisMonth,
  previousMonth,
  threeMonthsAgo,
  lastYear;

  String get title => switch (this) {
    CreditStatementDatePreset.thisMonth => U.s.thisMonth,
    CreditStatementDatePreset.previousMonth => U.s.previousMonth,
    CreditStatementDatePreset.threeMonthsAgo => "سه ماه قبل",
    CreditStatementDatePreset.lastYear => "سال قبل",
  };

  (UJalali, UJalali) range(UJalali now) => switch (this) {
    CreditStatementDatePreset.thisMonth => (now.firstDayOfMonth(), now),
    CreditStatementDatePreset.previousMonth => (now.add(months: -1).firstDayOfMonth(), now.add(months: -1).lastDayOfMonth()),
    CreditStatementDatePreset.threeMonthsAgo => (now.add(months: -3), now),
    CreditStatementDatePreset.lastYear => (now.add(years: -1), now),
  };
}

class CreditStatementFilter {
  CreditStatementFilter() {
    selectDatePreset(CreditStatementDatePreset.thisMonth);
  }

  final URx<UJalali> startDate = UJalali.now().firstDayOfMonth().obs;
  final URx<UJalali> endDate = UJalali.now().obs;
  final URxn<CreditStatementDatePreset> datePreset = URxn<CreditStatementDatePreset>();
  final URxList<CreditStatement> list = <CreditStatement>[].obs;
  final URxState state = URxState();

  void selectDatePreset(CreditStatementDatePreset preset) {
    final (UJalali start, UJalali end) = preset.range(UJalali.now());
    datePreset(preset);
    startDate(start);
    endDate(end);
  }

  Future<void> pickStartDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: startDate.value, lastDate: endDate.value);
    if (date == null) return;
    datePreset(null);
    startDate(date);
  }

  Future<void> pickEndDate() async {
    final UJalali? date = await UJalaliDatePicker.show(initialDate: endDate.value, firstDate: startDate.value, lastDate: UJalali.now());
    if (date == null) return;
    datePreset(null);
    endDate(date);
  }

  DateTime _startOfDay(UJalali date) => date.toDateTime().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  String get startDateTime => _startOfDay(startDate.value).toString();

  String get endDateTime => _startOfDay(endDate.value).add(const Duration(days: 1)).toString();
}

class StatusFaceController extends UBaseController {
  late AccountInfo accountInfo;
  final URxn<FileInfo> activeProfile = URxn<FileInfo>();
  List<CreditStatement> list = <CreditStatement>[];
  final CreditStatementFilter past = CreditStatementFilter();
  final CreditStatementFilter settled = CreditStatementFilter();

  void init({required AccountInfo accountInfo}) {
    this.accountInfo = accountInfo;
    read();
  }

  void read() {
    state.loading();
    Core.dataSource.creditCurrentStatement(
      page: U.s.statement,
      p: CreditStatementParams(accountId: accountInfo.accountId),
      onOk: (CreditStatementResponse response) {
        list = response.result;
        if (response.result.isEmpty) state.emptying();
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

  void readPast() => _readByDate(filter: past, isSettled: false);

  void readSettled() => _readByDate(filter: settled, isSettled: true);

  void _readByDate({required CreditStatementFilter filter, required bool isSettled}) {
    filter.state.loading();
    (isSettled ? Core.dataSource.creditSettledStatement : Core.dataSource.creditPastStatement)(
      page: U.s.statement,
      p: CreditStatementParams(
        accountId: accountInfo.accountId,
        startDateTime: filter.startDateTime,
        endDateTime: filter.endDateTime,
      ),
      onOk: (CreditStatementResponse response) {
        filter.list(response.result);
        if (filter.list.isEmpty)
          filter.state.emptying();
        else
          filter.state.loaded();
      },
      onError: (ErrorResponse response) {
        UToast.errorToast(message: response.errorMessage);
        filter.state.error();
      },
      onException: (String response) {
        filter.state.error();
      },
    );
  }

  void readLoanDetails({required String? billId, required Function(List<StatementLoanDetail> list) onOk}) {
    ULoading.show();
    Core.dataSource.statementLoanDetails(
      page: U.s.statement,
      p: StatementLoanDetailsParams(billId: billId),
      onOk: (StatementLoanDetailsResponse response) {
        ULoading.dismiss();
        onOk(response.result);
      },
      onError: (ErrorResponse response) {
        ULoading.dismiss();
        UToast.errorToast(message: response.errorMessage);
      },
      onException: (String response) {
        ULoading.dismiss();
      },
    );
  }

  void readCreditDetails({required String? billId, required Function(List<StatementCreditDetail> list) onOk}) {
    ULoading.show();
    Core.dataSource.statementCreditDetails(
      page: U.s.statement,
      p: StatementCreditDetailsParams(billId: billId),
      onOk: (StatementCreditDetailsResponse response) {
        ULoading.dismiss();
        onOk(response.result);
      },
      onError: (ErrorResponse response) {
        ULoading.dismiss();
        UToast.errorToast(message: response.errorMessage);
      },
      onException: (String response) {
        ULoading.dismiss();
      },
    );
  }
}
