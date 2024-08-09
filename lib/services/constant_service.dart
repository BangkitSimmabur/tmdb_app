import 'package:flutter/foundation.dart';
import 'package:tmdb_app/helpers/secure_storage_helper.dart';

class ConstantService with ChangeNotifier {

  String? sessionID;
  String? userID;
  String? activeUri;
  SecureStorageHelper storageHelper = SecureStorageHelper();

  ConstantService() {
    initClient();
  }

  Future<void> initClient() async {
    sessionID = await storageHelper.getSecureStorage("sessionID");
    userID = await storageHelper.getSecureStorage("userID");
    notifyListeners();

    return;
  }

}
