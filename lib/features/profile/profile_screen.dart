import 'package:anime_slayer/extensions/stings.dart';
import 'package:anime_slayer/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../auth/presentation/user_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userData ?? UserModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pop();
                    ref.read(authRepositoryProvider).logout();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                    shadowColor: Colors.redAccent.shade200,
                  ),
                )),
          ),
          const SizedBox(height: 20, width: double.infinity),
          CircleAvatar(
            radius: 50,
            backgroundImage: user.avatar.isEmpty
                ? const AssetImage('assets/default.png') as ImageProvider
                : NetworkImage(user.avatar.toImageUrl),
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
        ],
      ),
    );
  }
}
