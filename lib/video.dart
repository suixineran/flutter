import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    //  本地图片
    //  _controller = VideoPlayerController.asset('assets/video/your_video.mp4')  ;

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Butterfly Video'),
      // ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            print(_controller.value.aspectRatio);
            return Container(
              // width: 300, // 设置宽度为300像素
              height: 300, // 设置高度为300像素
              padding: EdgeInsets.fromLTRB(10, 20, 10, 30), 
              decoration: BoxDecoration(
    border: Border.all(
      color: Colors.red, // 设置边框颜色为红色
      width: 2, // 设置边框宽度为2
    ),
    
  ),
              child: Center(
                  child: AspectRatio(
                // aspectRatio: _controller.value.aspectRatio, // 设置宽高比，例如16:9 没生效
                aspectRatio: 16 / 9, // 设置宽高比，例如16:9 
                // aspectRatio: 9 / 16, // 设置宽高比，例如16:9 
                child: VideoPlayer(_controller),
              )
              ),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            // return const Center(
            //   child: CircularProgressIndicator(),
            // );
            return Image.asset(
              '../images/0601.jpeg', // 替换为你的图片路径
              height: 300, // 根据需要调整图片大小
              width: 300,
              // 其他可选参数，如fit: BoxFit.cover等
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
