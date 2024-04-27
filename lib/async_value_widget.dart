import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'loading_indicator.dart';


class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data,this.onRetry});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            ElevatedButton(
              onPressed: onRetry ?? () {},
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      loading: () => const LoadingIndicator(),
    );
  }
}
