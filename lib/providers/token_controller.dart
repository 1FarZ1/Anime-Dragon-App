import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/custom_logger.dart';
import 'local_auth_data_source.dart';

final tokenProvider = StateNotifierProvider<AccessTokenController, String?>((ref) {

  final localRepository= ref.watch(localAuthDataSourceProvider);
  return AccessTokenController(
    localRepository,
  );
});

class AccessTokenController extends StateNotifier<String?> {
  AccessTokenController(
    this.localRepository,
  ) : super(null) {
    initListener();
    state = localRepository.getToken();
  }

  final LocalAuthDataSource localRepository;
  Function? disposeListen;
  void setToken(String token) {
    state = token;
    localRepository.saveToken(token);
  }

  void clearToken() {
    state = '';
    localRepository.clearToken();
  }

  void initListener() {
    disposeListen = localRepository.listenKey((token) {
      AppLogger.logDebug('Token Changed: $token');
      state = token;
    });
  }

  void removeListener() {
    disposeListen?.call();
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }
}

enum SecureBox {
  token,
  user,
  cart,
}

