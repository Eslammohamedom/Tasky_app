import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static late final FlutterSecureStorage securedStorage;

  static Future<void> init() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      migrateOnAlgorithmChange: true,
    );

    securedStorage = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
    );
  }

  static Future<String?> getData({required String key}) async {
    return await securedStorage.read(key: key);
  }

  static Future<void> saveData({required String key, required String value}) async {
    await securedStorage.write(key: key, value: value);
  }

static Future<void> removeData({required String key})async{
      await securedStorage.delete(key: key);

}


}
