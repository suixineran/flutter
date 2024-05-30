import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DraggableVideoPlayer(),
    );
  }
}

class DraggableVideoPlayer extends StatefulWidget {
  @override
  _DraggableVideoPlayerState createState() => _DraggableVideoPlayerState();
}

class _DraggableVideoPlayerState extends State<DraggableVideoPlayer> {
  Offset _offset = Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: Draggable(  // 使用 Draggable Widget包裹视频播放器
            child: Container(
              width: 200.0,
              height: 150.0,
              color: Colors.black,
              child: Center(
                child: Text("Video Player"),
              ),
            ),
            feedback: Container(
              width: 200.0,
              height: 150.0,
              color: Colors.black,
              child: Center(
                child: Text("Video Player"),
              ),
            ),
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                _offset = offset;
              });
            },
          ),
        ),
      ],
    );
  }
}