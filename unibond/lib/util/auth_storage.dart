import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _authKey = 'AUTHORIZATION_KEY';

  // 인증 키 저장
  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _authKey, value: token);
  }

  // 인증 키 검색
  static Future<String?> getAuthToken() async {
    return await _storage.read(key: _authKey);
  }
}
