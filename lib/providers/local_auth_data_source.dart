
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_secure_storage/get_secure_storage.dart';


class  EnvironmentConfig {
  static const boxPassword = 'boxPassword';
}


final boxProvider = Provider<BoxManager>(
    (ref) => 
        BoxManager(
          GetSecureStorage(
            password: EnvironmentConfig.boxPassword,
          ),
        )
    );


class BoxManager {
  final GetSecureStorage box;

  BoxManager(this.box);

  void write(String key, String value) {
    box.write(key, value);
  }

  String? read(String key) {
    return box.read(key);
  }

  listenKey(String key, Function(dynamic) callback) {
    return box.listenKey(key, callback);
  }

  void remove(String key) {
    box.remove(key);
  }

  void clear() {
    box.erase();
  }
}

final localAuthDataSourceProvider = Provider<LocalAuthDataSource>((ref) {
  return LocalAuthDataSource(
    ref.watch(boxProvider),
  );
});

class LocalAuthDataSource {
  LocalAuthDataSource(this.boxManager);

  final BoxManager boxManager;

  void saveToken(String token) {
    boxManager.write('token', token);
  }

  String? getToken() {
    return boxManager.read('token');
  }

  void clearToken() {
    boxManager.remove('token');
  }

  Function listenKey(Function(dynamic) callback, [String key = 'token']) {
    return boxManager.listenKey(key, callback);
  }
}