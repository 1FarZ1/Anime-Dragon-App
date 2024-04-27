import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/anime_grid.dart';

class SearchAnimeView extends HookConsumerWidget {
  const SearchAnimeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // search bar with  the field in the middle , at the left back button and at the right 2 icons , one for filtering , and also the second for complex filtering,  remove borders
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  const Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: 'ادخل اسم الانمي ',
                          border: InputBorder.none,
                          hintTextDirection: TextDirection.rtl,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
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
            const ResultsView(),
          ],
        ),
      ),
    );
  }
}

class ResultsView extends StatelessWidget {
  const ResultsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimesGridView(
        animes: [
          for (int i = 0; i < 100; i++)
            AnimeModel(
              id: 1,
              title: 'One Piece',
              imageUrl: 'https://cdn.myanimelist.net/images/anime/6/73245.jpg',
              description:
                  'One Piece is a Japanese manga series written and illustrated by Eiichiro Oda. It has been serialized in Shueisha\'s Weekly Shōnen Jump magazine since July 22, 1997, and has been collected into 99 tankōbon volumes. The story follows the adventures of Monkey',
              rating: 8.58,
              isEnded: false,
              lastEpisode: 1000,
            ),
        ],
        onRefresh: () async {},
      ),
    );
  }
}
