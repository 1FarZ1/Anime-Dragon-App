import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/consts/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'play_back_controls.dart';

class WatchEpisodeScreen extends StatefulWidget {
  const WatchEpisodeScreen({super.key, required this.episodeNumber});
  final int episodeNumber;

  @override
  State<WatchEpisodeScreen> createState() => _WatchEpisodeScreenState();
}

class _WatchEpisodeScreenState extends State<WatchEpisodeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    final uri = Uri.parse(
        '${EndPoints.prodBaseUrl}/episodes/episode/stream/${widget.episodeNumber}');

    print(uri.path);
    _controller = VideoPlayerController.networkUrl(
      uri,
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    )..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                              child: VideoPlayer(_controller)),
                          _buildGradientOverlay(),
                        ],
                      ),
                    ),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
          ),
          _buildControls(context),

          // epsiode number on top
          Positioned(
            top: 50.0,
            right: 50.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'الحلقة ${widget.episodeNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: 80.0, // Set control bar height
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent.withOpacity(0.0),
              Colors.black.withOpacity(0.8)
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PlayButton(
                controller: _controller,
              ),
            ),
            Expanded(flex: 5, child: PlayBackControls(controller: _controller)),
            Expanded(child: LoopWidget(controller: _controller)),
            Expanded(child: ChangeSpeedWidget(controller: _controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
    );
  }
}

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 16.0,
      color: Colors.white,
      icon: Icon(
          widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      onPressed: () {
        setState(() {
          if (widget.controller.value.isPlaying) {
            widget.controller.pause();
          } else {
            widget.controller.play();
          }
        });
      },
    );
  }
}

//TODO`
class LoopWidget extends StatefulWidget {
  const LoopWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<LoopWidget> createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.setLooping(!widget.controller.value.isLooping);
        });
      },
      child: Icon(
        widget.controller.value.isLooping ? Icons.loop : Icons.loop_outlined,
        size: 16.0,
      ),
    );
  }
}

class ChangeSpeedWidget extends StatefulWidget {
  const ChangeSpeedWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<ChangeSpeedWidget> createState() => _ChangeSpeedWidgetState();
}

class _ChangeSpeedWidgetState extends State<ChangeSpeedWidget> {
  getNextSpeed() {
    if (widget.controller.value.playbackSpeed == 1.0) {
      return 1.25;
    } else if (widget.controller.value.playbackSpeed == 1.25) {
      return 1.5;
    } else if (widget.controller.value.playbackSpeed == 1.5) {
      return 1.75;
    } else if (widget.controller.value.playbackSpeed == 1.75) {
      return 2.0;
    } else {
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          widget.controller.setPlaybackSpeed(getNextSpeed());
        });
      },
      child: Text('${widget.controller.value.playbackSpeed}x',
          style: TextStyle(
              fontSize: 7.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }
}

class SoundWidget extends HookWidget {
  const SoundWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: controller.value.volume,
      onChanged: (value) {
        controller.setVolume(value);
      },
      min: 0,
      max: 1,
      divisions: 10,
    );
  }
}

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (widget.controller.value.isPlaying) {
                widget.controller.pause();
              } else {
                widget.controller.play();
              }
            });
          },
          child: Icon(
            widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (widget.controller.value.volume == 0) {
                widget.controller.setVolume(1);
              } else {
                widget.controller.setVolume(0);
              }
            });
          },
          child: Icon(
            widget.controller.value.volume == 0
                ? Icons.volume_off
                : Icons.volume_up,
          ),
        ),
      ],
    );
  }
}
