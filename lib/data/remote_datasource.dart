part of "data.dart";

class RemoteDataSource {
  Future<void> onAuthorized(Response response) async {
    if (response.statusCode == 401 || response.statusCode == 412) {
      await ULocalStorage.clear();
      await UNavigator.offAll(const SplashPage());
    }
  }

  Future<void> onTooManyRequests() => TooManyRequestsDialog.show();

  Future<void> onServerError({required String page, required String request, required String message}) => RequestErrorDialog.show(
    page: page,
    request: request,
    message: message,
  );

  Future<void> _send({
    required String page,
    required String method,
    required String endpoint,
    required Function(Response r) onSuccess,
    required Function(Response r) onError,
    required Function(String e) onException,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final String request = endpoint.split("/").last;
    await UHttpClient.send(
      method: method,
      endpoint: endpoint,
      headers: headers,
      body: body,
      onSuccess: onSuccess,
      timeout: const Duration(seconds: 10),
      retryAmount: 2,
      onError: (Response r) {
        if (r.statusCode == 429) {
          onException(U.s.tooManyRequests);
          onTooManyRequests();
        } else if (r.statusCode >= 500) {
          final String message = "${U.s.serverError} (${r.statusCode})";
          onException(message);
          onServerError(page: page, request: request, message: message);
        } else {
          onError(r);
          onAuthorized(r);
        }
      },
      onException: (String e) {
        onException(e);
        onServerError(page: page, request: request, message: e);
      },
    );
  }

  Future<(PreRegisterResponse?, ErrorResponse?, String?)> preRegister({
    required PreRegisterParams p,
    required Function(PreRegisterResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (PreRegisterResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      endpoint: "${AppConstants.baseUrl}/preRegister",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1"},
      onSuccess: (Response r) {
        final PreRegisterResponse ok = PreRegisterResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(RegisterResponse?, ErrorResponse?, String?)> register({
    required RegisterParams p,
    required Function(RegisterResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (RegisterResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      headers: <String, String>{"clientType": "1"},
      endpoint: "${AppConstants.baseUrl}/register",
      body: p.toMap(),
      onSuccess: (Response r) {
        final RegisterResponse ok = RegisterResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(GetFileInfoResponse?, ErrorResponse?, String?)> getFileInfo({
    required Function(GetFileInfoResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (GetFileInfoResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      body: <String, dynamic>{},
      method: "POST",
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/getFileInfo",
      onSuccess: (Response r) {
        final GetFileInfoResponse ok = GetFileInfoResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(TransactionResponse?, ErrorResponse?, String?)> viewTransaction({
    required TransactionParams p,
    required Function(TransactionResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (TransactionResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/viewTransaction",
      onSuccess: (Response r) {
        final TransactionResponse ok = TransactionResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(TransactionDetailResponse?, ErrorResponse?, String?)> viewTransactionDetail({
    required TransactionDetailParams p,
    required Function(TransactionDetailResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (TransactionDetailResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/viewTransactionDetails",
      onSuccess: (Response r) {
        final TransactionDetailResponse ok = TransactionDetailResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(AccountStatementResponse?, ErrorResponse?, String?)> accountStatement({
    required AccountStatementParams p,
    required Function(AccountStatementResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (AccountStatementResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/accountStatement",
      onSuccess: (Response r) {
        final AccountStatementResponse ok = AccountStatementResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(CreditStatementResponse?, ErrorResponse?, String?)> creditCurrentStatement({
    required CreditStatementParams p,
    required Function(CreditStatementResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (CreditStatementResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/creditCurrentStatement",
      onSuccess: (Response r) {
        final CreditStatementResponse ok = CreditStatementResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(CreditStatementResponse?, ErrorResponse?, String?)> creditPastStatement({
    required CreditStatementParams p,
    required Function(CreditStatementResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (CreditStatementResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/creditPastStatement",
      onSuccess: (Response r) {
        final CreditStatementResponse ok = CreditStatementResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(CreditStatementResponse?, ErrorResponse?, String?)> creditSettledStatement({
    required CreditStatementParams p,
    required Function(CreditStatementResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (CreditStatementResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/creditSettledStatement",
      onSuccess: (Response r) {
        final CreditStatementResponse ok = CreditStatementResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(StatementLoanDetailsResponse?, ErrorResponse?, String?)> statementLoanDetails({
    required StatementLoanDetailsParams p,
    required Function(StatementLoanDetailsResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (StatementLoanDetailsResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/statementLoanDetails",
      onSuccess: (Response r) {
        final StatementLoanDetailsResponse ok = StatementLoanDetailsResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(StatementCreditDetailsResponse?, ErrorResponse?, String?)> statementCreditDetails({
    required StatementCreditDetailsParams p,
    required Function(StatementCreditDetailsResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (StatementCreditDetailsResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/statementCreditDetails",
      onSuccess: (Response r) {
        final StatementCreditDetailsResponse ok = StatementCreditDetailsResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(FileDetailsResponse?, ErrorResponse?, String?)> fileDetails({
    required FileDetailsParams p,
    required Function(FileDetailsResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (FileDetailsResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/fileDetails",
      onSuccess: (Response r) {
        final FileDetailsResponse ok = FileDetailsResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(InquiryLoanResponse?, ErrorResponse?, String?)> inquiryLoan({
    required InquiryLoanParams p,
    required Function(InquiryLoanResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (InquiryLoanResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/inquiryLoan",
      onSuccess: (Response r) {
        final InquiryLoanResponse ok = InquiryLoanResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(KalabargBalanceResponse?, ErrorResponse?, String?)> kalabargBalance({
    required KalabargBalanceParams p,
    required Function(KalabargBalanceResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (KalabargBalanceResponse?, ErrorResponse?, String?) result = (null, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/kalabargBalance",
      onSuccess: (Response r) {
        final KalabargBalanceResponse ok = KalabargBalanceResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(bool, ErrorResponse?, String?)> registerAnonymousCard({
    required RegisterCardParams p,
    required VoidCallback? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
    required String page,
  }) async {
    (bool, ErrorResponse?, String?) result = (false, null, null);
    await _send(
      page: page,
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "X-Person": ULocalStorage.getString(AppConstants.personId) ?? "", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/registerAnonymousCard",
      onSuccess: (Response r) {
        result = (true, null, null);
        onOk?.call();
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (false, err, null);
        onError?.call(err);
      },
      onException: (String e) {
        result = (false, null, e);
        onException?.call(e);
      },
    );
    return result;
  }
}
