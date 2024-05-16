import 'package:anime_slayer/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayBackControls extends StatelessWidget {
  const PlayBackControls({
    super.key,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: 16.0,
          color: Colors.white,
          icon: const Icon(Icons.replay_10),
          onPressed: () {
            _controller.seekTo(
                _controller.value.position - const Duration(seconds: 10));
          },
        ),
        Expanded(
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: AppColors.primaryColor,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        IconButton(
          iconSize: 16.0,
          color: Colors.white,
          icon: const Icon(Icons.forward),
          onPressed: () {
            _controller.seekTo(
                _controller.value.position + const Duration(seconds: 10));
          },
        ),
      ],
    );
  }
}
