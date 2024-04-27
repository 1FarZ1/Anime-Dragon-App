import 'dart:async';

import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'anime_controller.dart';
import 'widgets/anime_grid.dart';

class SearchAnimeView extends HookConsumerWidget {
  SearchAnimeView({super.key});

  Timer? _debounce;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    final animes = ref.watch(animeSearchProvider(query.value));
    return Scaffold(
      body: Column(
        children: [
          30.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: TextField(
                      onChanged: (val) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          query.value = val;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'ادخل اسم الانمي ',
                        border: InputBorder.none,
                        hintTextDirection: TextDirection.rtl,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // search result
          ResultsView(
            animes: animes.asData?.value ?? [],
          ),
        ],
      ),
    );
  }
}

class ResultsView extends StatelessWidget {
  const ResultsView({
    super.key,
    required this.animes,
  });

  final List<AnimeModel> animes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimesGridView(
        animes: animes,
        onRefresh: () async {},
      ),
    );
  }
}
