import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/anime_grid.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'anime_drawer.dart';
import 'animes/presentation/logic/anime_controller.dart';

class MainView extends ConsumerWidget {
  MainView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(animesControllerProvider).animes;

    return Scaffold(
        key: _scaffoldKey,
        drawer: const AnimeDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
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
              icon: const Icon(Icons.grid_view),
              onPressed: () {
                // ref.read(animeViewControllerProvider.notifier).switchView();
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
            )),
          ],
        ));
  }
}
