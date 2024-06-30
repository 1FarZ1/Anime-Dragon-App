import 'package:anime_slayer/features/episode/watch_episode_screen.dart';
import 'package:flutter/material.dart';

class EpisodesView extends StatelessWidget {
  const EpisodesView({
    super.key,
    required this.numberOfEpisodes,
    required this.animeId,
  });

  final int numberOfEpisodes;
  final int animeId;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: numberOfEpisodes,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text('الحلقة ${index + 1}'),
            trailing: const Icon(Icons.remove_red_eye),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WatchEpisodeScreen(
                      episodeNumber: index + 1,
                      animeId: animeId ,
                    ))));
      },
    );
  }
}
