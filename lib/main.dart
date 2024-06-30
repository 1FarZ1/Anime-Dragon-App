import 'package:get_secure_storage/get_secure_storage.dart';

import 'app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/local_auth_data_source.dart';
import 'utils/provider_logger.dart';


initBox() async{
    await GetSecureStorage.init(password: EnvironmentConfig.boxPassword);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBox();
  runApp(ProviderScope(observers: [ProviderLogger()], child: const AppStartupWidget()));
}
