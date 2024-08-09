import 'package:flutter/foundation.dart';
import 'package:tmdb_app/helpers/secure_storage_helper.dart';

class ConstantService with ChangeNotifier {
  String? sessionID;
  int? userID;

  ConstantService() {
    initClient();
  }

  Future<void> initClient() async {
    sessionID = await SecureStorageHelper.getSecureStorage("sessionID");
    userID =
        int.parse(await SecureStorageHelper.getSecureStorage("userID") ?? "");
    notifyListeners();

    return;
  }
}
