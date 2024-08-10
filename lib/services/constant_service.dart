import 'package:flutter/foundation.dart';
import 'package:tmdb_app/helpers/secure_storage_helper.dart';

class ConstantService with ChangeNotifier {
  String? sessionID;
  int? userID;

  ConstantService() {
    initClient();
  }

  Future<void> initClient() async {
    // sessionID = await SecureStorageHelper.getSecureStorage("sessionID");
    // userID =
    //     int.parse(await SecureStorageHelper.getSecureStorage("userID") ?? "");

    sessionID = "6efdfa82f37793fd87c15a73fd432df6fb920f2d";
    userID = 21429407;
    notifyListeners();

    return;
  }
}
