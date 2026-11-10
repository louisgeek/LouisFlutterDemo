import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayer({super.key, required this.videoUrl});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    // 1. 初始化 VideoPlayerController
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _videoPlayerController.initialize();

    // 2. 初始化 ChewieController (UI 控制器)
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      // 自动播放
      looping: false,
      // 是否循环
      aspectRatio: _videoPlayerController.value.aspectRatio,
      // 保持视频比例
      // customControls: ... 可以自定义控制UI
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    // 刷新 UI
    setState(() {});
  }

  @override
  void dispose() {
    // 必须销毁，释放资源
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child:
            _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const CircularProgressIndicator(), // 加载中显示菊花
    );
  }
}
