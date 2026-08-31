part of "data.dart";

class RemoteDataSource {
  Future<void> onAuthorized(Response response) async {
    if (response.statusCode == 401) {
      await ULocalStorage.clear();
      await UNavigator.offAll(const SplashPage());
    }
  }

  Future<(PreRegisterResponse?, ErrorResponse?, String?)> preRegister({
    required PreRegisterParams p,
    required Function(PreRegisterResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
  }) async {
    (PreRegisterResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
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
        onAuthorized(r);
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
  }) async {
    (RegisterResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
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
        onAuthorized(r);
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
  }) async {
    (GetFileInfoResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
      method: "POST",
      headers: <String, String>{"clientType": "1", "Authorization": ?ULocalStorage.getToken()},
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
        onAuthorized(r);
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
  }) async {
    (TransactionResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "Authorization": ?ULocalStorage.getToken()},
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
        onAuthorized(r);
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
  }) async {
    (AccountStatementResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "Authorization": ?ULocalStorage.getToken()},
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
        onAuthorized(r);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }

  Future<(GetAccountFunctionCodesResponse?, ErrorResponse?, String?)> getAccountFunctionCodes({
    required GetAccountFunctionCodesParams p,
    required Function(GetAccountFunctionCodesResponse r)? onOk,
    required Function(ErrorResponse e)? onError,
    required Function(String e)? onException,
  }) async {
    (GetAccountFunctionCodesResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
      method: "POST",
      body: p.toMap(),
      headers: <String, String>{"clientType": "1", "Authorization": ?ULocalStorage.getToken()},
      endpoint: "${AppConstants.baseUrl}/getAccountFunctionCodes",
      onSuccess: (Response r) {
        final GetAccountFunctionCodesResponse ok = GetAccountFunctionCodesResponse.fromJson(r.body);
        result = (ok, null, null);
        onOk?.call(ok);
      },
      onError: (Response r) {
        final ErrorResponse err = ErrorResponse.fromJson(r.body);
        result = (null, err, null);
        onError?.call(err);
        onAuthorized(r);
      },
      onException: (String e) {
        result = (null, null, e);
        onException?.call(e);
      },
    );
    return result;
  }
}
