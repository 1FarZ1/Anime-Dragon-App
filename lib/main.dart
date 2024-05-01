import 'app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider_logger.dart';

void main() {
  runApp(ProviderScope(observers: [ProviderLogger()], child: const AppStartupWidget()));
}
