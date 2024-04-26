import 'package:anime_slayer/anime_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
            },
          ),
          title: const Text('اخر التحديثات'),
          // actions for seach and  report issue
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // showSearch(context: context, delegate: AnimeSearchDelegate());
              },
            ),
            IconButton(
              icon: const Icon(Icons.report),
              onPressed: () {
                // showReportIssue(context);
              },
            ),
          ],
        ),
        body: const Column(
          children: [
            Expanded(child: AnimeGrid()),
          ],
        ));
  }
}
