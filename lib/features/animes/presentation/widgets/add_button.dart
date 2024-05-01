import 'dart:developer';

import 'package:anime_slayer/features/animeList/anime_list_controller.dart';
import 'package:anime_slayer/features/animes/data/animes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddReviewButton extends ConsumerWidget {
  const AddReviewButton({
    super.key,
    required this.text,
    required this.icon,
    required this.animeId,
  });

  final String text;
  final IconData icon;
  final int animeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final value = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddReviewDialog();
            });
        if (value != -1) {
          ref.read(animesRepositoryProvider).addReviewToAnime(
              AddReviewRequest(animeId: animeId, rating: value));
        } else {
          log('canceled');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 30,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AddToMyListButton extends ConsumerWidget {
  const AddToMyListButton({
    super.key,
    required this.text,
    required this.icon,
    required this.animeId,
  });

  final String text;
  final IconData icon;
  final int animeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    checkIfIsInList() {
      final list = ref.watch(listAnimesController).asData?.value ?? [];
      return list.any((element) => element.id == animeId);
    }

    return GestureDetector(
      onTap: () {
        ref.read(listAnimesController.notifier).addListAnime(animeId);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            checkIfIsInList() ? Icons.check : icon,
            color: Colors.grey,
            size: 30,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AddReviewDialog extends HookWidget {
  const AddReviewDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sliderValue = useState(5.0);
    return AlertDialog(
      title: const Text('اضافة تقييم'),
      content: SizedBox(
        height: 100.h,
        child: Slider(
          value: sliderValue.value,
          onChanged: (value) {
            sliderValue.value = value;
          },
          min: 0,
          max: 10,
          divisions: 10,
          label: sliderValue.value.round().toString(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop(-1);
          },
          child: const Text('الغاء'),
        ),
        TextButton(
          onPressed: () {
            context.pop(sliderValue.value);
          },
          child: const Text('اضافة'),
        ),
      ],
    );
  }
}
