import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/anime_grid.dart';
import 'package:anime_slayer/features/favorites/favorite_screen.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'anime_drawer.dart';
import 'animes/presentation/logic/anime_controller.dart';

enum ViewStyle { grid, list }

class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(animesControllerProvider).animes;
    final viewStyle = useState<ViewStyle>(ViewStyle.grid);

    return Scaffold(
        drawer: const AnimeDrawer(),
        appBar: AppBar(
          leading: const OpenDrawerButton(),
          title: Text('اخر التحديثات',
              style: TextStyle(
                fontSize: 18.sp,
              )),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.pushNamed(
                  AppRoutes.search.name,
                );
              },
            ),
            IconButton(
              icon: Icon(viewStyle.value == ViewStyle.grid
                  ? Icons.list
                  : Icons.grid_view),
              onPressed: () {
                viewStyle.value = viewStyle.value == ViewStyle.grid
                    ? ViewStyle.list
                    : ViewStyle.grid;
              },
            ),
            IconButton(
              icon: const Icon(Icons.report, color: Colors.red),
              onPressed: () {
                // showReportIssue(context);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: AnimesView(
              animes: animes,
              onError: () => ref.invalidate(animesControllerProvider),
              onRefresh: () async {
                ref.invalidate(animesControllerProvider);
              },
              viewStyle: viewStyle.value,
            )),
          ],
        ));
  }
}
