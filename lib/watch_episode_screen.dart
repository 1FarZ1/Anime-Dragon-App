import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchEpisodeScreen extends StatefulWidget {
  const WatchEpisodeScreen({super.key});

  @override
  State<WatchEpisodeScreen> createState() => _WatchEpisodeScreenState();
}

class _WatchEpisodeScreenState extends State<WatchEpisodeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('http://192.168.43.176:5500/api/episodes/episode/stream/1'),
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
    return Center(
      child: _controller.value.isInitialized
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.value.duration.toString(),
                ),
                Text(
                  _controller.value.isBuffering.toString(),
                ),

                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(
                    _controller,
                  ),
                ),

                ValueListenableBuilder(
                  valueListenable: ValueNotifier(position),
                  builder: (context, value, child) {
                    return Slider(
                      value: value,
                      onChanged: (value) {
                        setState(() {
                          _controller.seekTo(Duration(seconds: value.toInt()));
                        });
                      },
                      min: 0,
                      max: _controller.value.duration.inSeconds.toDouble(),
                      divisions: _controller.value.duration.inSeconds,
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),

                    // change the sound
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_controller.value.volume == 0) {
                            _controller.setVolume(1);
                          } else {
                            _controller.setVolume(0);
                          }
                        });
                      },
                      child: Icon(
                        _controller.value.volume == 0
                            ? Icons.volume_off
                            : Icons.volume_up,
                      ),
                    ),
                  ],
                ),

                // change the sound with slider
                Slider(
                  value: _controller.value.volume,
                  onChanged: (value) {
                    setState(() {
                      _controller.setVolume(value);
                    });
                  },
                  min: 0,
                  max: 1,
                  divisions: 10,
                ),

                // change the speed of the video
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      value: _controller.value.playbackSpeed,
                      onChanged: (value) {
                        setState(() {
                          _controller.setPlaybackSpeed(value);
                        });
                      },
                      min: 0.5,
                      max: 2,
                      divisions: 15,
                    ),
                    // bring it to default speed
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller.setPlaybackSpeed(1);
                        });
                      },
                      child: const Text('1x'),
                    ),
                  ],
                ),

                // loop mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller.setLooping(!_controller.value.isLooping);
                        });
                      },
                      child: Icon(
                        _controller.value.isLooping
                            ? Icons.loop
                            : Icons.loop_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
