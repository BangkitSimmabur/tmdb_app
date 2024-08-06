import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/helpers/secure_storage_helper.dart';

class ConstantService with ChangeNotifier {

  String? token;
  String? activeUri;
  SecureStorageHelper storageHelper = SecureStorageHelper();

  ConstantService() {
    initClient();
  }

  Future<void> initClient() async {
    token = await storageHelper.getSecureStorage("jwt");
    notifyListeners();

    return developer.log('Current token: $token');
  }

}
