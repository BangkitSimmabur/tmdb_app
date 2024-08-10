import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Class to handle data on secured storage, data type store is only String
class SecureStorageHelper {
  /// Function to store data
  static Future<void> writeSecureStorage(
    String key,
    String value,
  ) async {
    await const FlutterSecureStorage().write(key: key, value: value);
  }

  /// Function to delete stored data based on data's key
  static Future<void> deleteSecureStorage(String key) async {
    await const FlutterSecureStorage().delete(key: key);
  }

  /// Function to specifically fetch session id
  static Future<String?> getSession() async {
    return await const FlutterSecureStorage().read(key: "sessionID");
  }

  /// Function to specifically fetch user id
  static Future<String?> getUserID() async {
    return await const FlutterSecureStorage().read(key: "userID");
  }
}
