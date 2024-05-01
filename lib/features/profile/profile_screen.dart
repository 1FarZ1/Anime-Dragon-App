import 'package:anime_slayer/extensions/stings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../auth/presentation/user_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userData!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20, width: double.infinity),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.avatar.toImageUrl),
          ),
          20.verticalSpace,
          Text(
            user.email,
            style: const TextStyle(fontSize: 20),
          ),
          20.verticalSpace,
          Text(
            user.name,
            style: const TextStyle(fontSize: 20),
          ),

          //name
          20.verticalSpace,
          ElevatedButton(
            onPressed: () {
              ref.read(userProvider.notifier).clearUser();
              context.pop();
            },
            child: const Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
