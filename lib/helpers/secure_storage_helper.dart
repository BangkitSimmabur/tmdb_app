import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureStorage(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureStorage(String key) async {
    return await secureStorage.read(key: key);
  }

  Future<void> deleteSecureStorage(String key, String value) async {
    await secureStorage.delete(key: key);
  }
}