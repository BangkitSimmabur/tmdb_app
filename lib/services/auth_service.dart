import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/secure_storage_helper.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/services/network_service.dart';

class AuthService extends NetworkService {
  AuthService(super.constantService);

  Future<HandlingServerLog> login(String userName, String password) async {
    HandlingServerLog tokenLog = await getRequestToken();

    if (!tokenLog.success!) {
      return tokenLog;
    }

    HandlingServerLog loginLog = await authenticateRequestToken(
      userName,
      password,
      tokenLog.data['request_token'],
    );

    if (!loginLog.success!) {
      return loginLog;
    }

    HandlingServerLog sessionLog = await createSession(
      loginLog.data['request_token'],
    );

    if (!sessionLog.success!) {
      return sessionLog;
    }

    HandlingServerLog userLog = await retrieveUserFromSession(
      sessionLog.data["session_id"],
    );


    if (userLog.data["id"] != null) {
      constantService.userID = userLog.data["id"];
      SecureStorageHelper.writeSecureStorage(
        "userID",
        userLog.data["id"].toString(),
      );
    }

    return userLog;
  }

  Future<HandlingServerLog> getRequestToken() async {
    HandlingServerLog serverLog =
        await doHttpGet('/authentication/token/new?api_key=${Constant.tmdbApiKey}');

    return serverLog;
  }

  Future<HandlingServerLog> authenticateRequestToken(
    String userName,
    String password,
    token,
  ) async {
    Map<String, String> loginReqBody = {
      "username": userName,
      "password": password,
      "request_token": token,
    };

    HandlingServerLog serverLog = await doHttpPost(
        '/authentication/token/validate_with_login?api_key=${Constant.tmdbApiKey}',
        loginReqBody);

    return serverLog;
  }

  Future<HandlingServerLog> createSession(String token) async {
    Map<String, String> sessionReqBody = {
      "request_token": token,
    };

    HandlingServerLog serverLog = await doHttpPost(
        '/authentication/session/new?api_key=${Constant.tmdbApiKey}',
        sessionReqBody);

    if (serverLog.success == true) {
      constantService.sessionID = serverLog.data["session_id"];
      SecureStorageHelper.writeSecureStorage(
        "sessionID",
        serverLog.data["session_id"],
      );
    }

    return serverLog;
  }

  Future<HandlingServerLog> retrieveUserFromSession(String sessionId) async {
    HandlingServerLog serverLog = await doHttpGet(
        '/account?api_key=${Constant.tmdbApiKey}&session_id=$sessionId');

    return serverLog;
  }
}
