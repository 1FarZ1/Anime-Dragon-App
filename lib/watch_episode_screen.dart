import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(
            'http://192.168.43.176:5500/api/episodes/episode/stream/${widget.episodeNumber}'),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  double position = 0;
  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        position = _controller.value.position.inSeconds.toDouble();
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode ${widget.episodeNumber}'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VideoView(controller: _controller),
                  VideoSlider(
                    controller: _controller,
                    position: position,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OptionsWidget(
                        controller: _controller,
                      ),
                      // ChangeSpeedWidget(
                      //   controller: _controller,
                      // ),
                      LoopWidget(
                        controller: _controller,
                      ),
                    ],
                  ),
                  // SoundWidget(
                  //   controller: _controller,
                  // ),
                ],
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}

class LoopWidget extends StatefulWidget {
  const LoopWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<LoopWidget> createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.controller.setLooping(!widget.controller.value.isLooping);
            });
          },
          child: Icon(
            widget.controller.value.isLooping ? Icons.circle : Icons.loop,
          ),
        ),
      ],
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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.controller.setPlaybackSpeed(0.5);
            });
          },
          child: const Text('0.5x'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.controller.setPlaybackSpeed(1);
            });
          },
          child: const Text('1x'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.controller.setPlaybackSpeed(1.5);
            });
          },
          child: const Text('1.5x'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.controller.setPlaybackSpeed(2);
            });
          },
          child: const Text('2x'),
        ),
      ],
    );
  }
}

class VideoSlider extends StatefulWidget {
  const VideoSlider(
      {super.key, required this.controller, required this.position});
  final VideoPlayerController controller;
  final double position;

  @override
  State<VideoSlider> createState() => _VideoSliderState();
}

class _VideoSliderState extends State<VideoSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.position,
      onChanged: (value) {
        setState(() {
          widget.controller.seekTo(Duration(seconds: value.toInt()));
        });
      },
      min: 0,
      max: widget.controller.value.duration.inSeconds.toDouble(),
    );
  }
}

class SoundWidget extends StatefulWidget {
  const SoundWidget({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<SoundWidget> createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.controller.value.volume,
      onChanged: (value) {
        setState(() {
          widget.controller.setVolume(value);
        });
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

class VideoView extends StatelessWidget {
  const VideoView({
    super.key,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(
        _controller,
      ),
    );
  }
}
