import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static Future<void> writeSecureStorage(
    String key,
    String value,
  ) async {
    await const FlutterSecureStorage().write(key: key, value: value);
  }

  static Future<String?> getSecureStorage(String key) async {
    return await const FlutterSecureStorage().read(key: key);
  }

  static Future<void> deleteSecureStorage(String key) async {
    await const FlutterSecureStorage().delete(key: key);
  }

  static Future<String?> getSession() async {
    return await const FlutterSecureStorage().read(key: "sessionID");
  }
  static Future<String?> getUserID() async {
    return await const FlutterSecureStorage().read(key: "userID");
  }
}
