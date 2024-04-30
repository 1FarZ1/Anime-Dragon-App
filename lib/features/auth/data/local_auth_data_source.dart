


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/shared_pref.dart';


final localAuthDataSourceProvider = Provider<LocalAuthDataSource>((ref) {
  return LocalAuthDataSource(sharedPreferences: ref.watch(sharedPrefProvider).requireValue);
});

class LocalAuthDataSource {
  final SharedPreferences sharedPreferences;

  LocalAuthDataSource({required this.sharedPreferences});

  Future<void> saveToken(String? token) async {
    if(token == null) return;
    await sharedPreferences.setString(Pref.token.name, token);
  }

  String? getToken()  {
    return sharedPreferences.getString(Pref.token.name);
  }

  Future<void> deleteToken() async {
    await sharedPreferences.remove(Pref.token.name);
  }

  
}

enum Pref {
  token
}