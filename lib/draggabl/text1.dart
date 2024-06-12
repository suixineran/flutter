import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DraggableVideoPlayer(),
    );
  }
}

class DraggableVideoPlayer extends StatefulWidget {
  const DraggableVideoPlayer({super.key});

  @override
  _DraggableVideoPlayerState createState() => _DraggableVideoPlayerState();
}

class _DraggableVideoPlayerState extends State<DraggableVideoPlayer> {
  Offset _offset = const Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: Draggable(  // 使用 Draggable Widget包裹视频播放器
            feedback: Container(
              width: 200.0,
              height: 150.0,
              color: Colors.black,
              child: const Center(
                child: Text("Video Player"),
              ),
            ),
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                _offset = offset;
              });
            },  // 使用 Draggable Widget包裹视频播放器
            child: Container(
              width: 200.0,
              height: 150.0,
              color: Colors.black,
              child: const Center(
                child: Text("Video Player"),
              ),
            ),
          ),
        ),
      
      
      
      ],
    );
  }
}