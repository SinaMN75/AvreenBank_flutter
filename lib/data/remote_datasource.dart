part of "data.dart";

class RemoteDataSource {
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
      headers: <String, String>{
        "Content-Type": "application/json",
        "accept": "application/json",
        "clientType": "1",
      },
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
  }) async {
    (RegisterResponse?, ErrorResponse?, String?) result = (null, null, null);
    await UHttpClient.send(
      method: "POST",
      headers: <String, String>{
        "Content-Type": "application/json",
        "accept": "application/json",
        "clientType": "1",
      },
      endpoint: "${AppConstants.baseUrl}/register",
      body: p.toMap().add("apiKey", U.apiKey).add("token", ULocalStorage.getToken()),
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
}
