import 'dart:async';

import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/animes/presentation/search_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logic/anime_controller.dart';
import 'logic/filter_type.dart';
import 'results_view.dart';

class SearchAnimeView extends HookConsumerWidget {
  SearchAnimeView({super.key});

  Timer? _debounce;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    final currentFilter = useState(FilterType.title);
    final animes = ref.watch(animeSearchProvider(SearchOption(
      query: query.value,
      filter: currentFilter.value,
    )));
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
                    context.pop();
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
                  onPressed: () async {
                    // show dialog
                    final result = await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return SearchOptionDialog(
                          currentFilter: currentFilter.value,
                        );
                      },
                    );
                    if (result != null) {
                      currentFilter.value = result as FilterType;
                    }
                  },
                ),

                //TODO:ADD this later on
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          !animes.isLoading
              ? ResultsView(
                  animes: animes.asData?.value ?? [],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}

class SearchOptionDialog extends HookConsumerWidget {
  const SearchOptionDialog({
    super.key,
    required this.currentFilter,
  });

  final FilterType currentFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilterDialog = useState<FilterType>(currentFilter);
    return AlertDialog(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      title: const Text('الترتيب حسب'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<FilterType>(
            title: const Text('الاسم'),
            value: FilterType.title,
            groupValue: currentFilterDialog.value,
            onChanged: (val) {
              currentFilterDialog.value = val!;
            },
          ),
          RadioListTile<FilterType>(
            title: const Text('تاريخ الاصدار'),
            value: FilterType.releaseDate,
            groupValue: currentFilterDialog.value,
            onChanged: (val) {
              currentFilterDialog.value = val!;
            },
          ),
          RadioListTile<FilterType>(
            title: const Text('التقييم'),
            value: FilterType.rating,
            groupValue: currentFilterDialog.value,
            onChanged: (val) {
              currentFilterDialog.value = val!;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop(
              currentFilterDialog.value,
            );
          },
          child: const Text('تم'),
        ),
      ],
    );
  }
}
