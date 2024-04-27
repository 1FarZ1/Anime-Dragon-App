import 'dart:developer';

import 'app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(observers: [Logger()], child: const AppStartupWidget()));
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    inspect(
      {
        'provider': provider.name,
        'previousValue': previousValue,
        'newValue': newValue,
      },
    );
  }
}
