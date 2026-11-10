import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HLSPlayerPage extends StatefulWidget {
  const HLSPlayerPage({super.key});

  @override
  State<HLSPlayerPage> createState() => _HLSPlayerPageState();
}

class _HLSPlayerPageState extends State<HLSPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    String hlsUrl ='http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8';
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(hlsUrl),
    );

    try {
      await _controller.initialize();
      setState(() {});
      _controller.play();
    } catch (e) {
      debugPrint('播放器初始化失败: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _controller.value.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 视频画面
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),

            // 进度条
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.grey,
                backgroundColor: Colors.white24,
              ),
            ),

            // 控制栏
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 当前时间
                  ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, value, child) {
                      return Text(
                        _formatDuration(value.position),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),

                  const SizedBox(width: 16),

                  // 播放/暂停
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 总时间
                  Text(
                    _formatDuration(_controller.value.duration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        )
            : const CircularProgressIndicator(),
    );
  }
}