import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenS extends StatefulWidget {
  const VideoPlayerScreenS({super.key});
  @override
  State<VideoPlayerScreenS> createState() => _VideoPlayerScreenStateS();
}

class _VideoPlayerScreenStateS extends State<VideoPlayerScreenS> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    start1();
  }

// 模拟网络链接
  void start1() async {
    await Future.delayed(const Duration(seconds: 1)); // 等待
    setState(() {
      // _controller.play();
    });
  }

  @override
  void dispose() {
      print('销毁视频222');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // print(_controller.value.aspectRatio);
              return SizedBox(
                height: 100,
                child: Center(
                    child: AspectRatio(
                  aspectRatio: 16 / 9, // 设置宽高比，例如16:9
                  child: VideoPlayer(_controller),
                )),
              );
            } else {
              // return Image.asset(
              //   '../images/0601.jpeg', // 替换为你的图片路径
              //   height: 100,
              // );
              return Container();
            }
          },
        ),
      ],
    );
  }
}
