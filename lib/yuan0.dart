import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('从图片截图圆形区域并加圆环')),
        body: Center(
          child: CircleCropImageWithRing(
            imageUrl:'images/target.png', // 替换成你自己的图片URL
            cropSize: 100.0, // 截图区域的直径
            offset: Offset(50, 50), // 截图区域在图片中的偏移量
          ),
        ),
      ),
    );
  }
}

class CircleCropImageWithRing extends StatelessWidget {
  final String imageUrl;
  final double cropSize;
  final Offset offset;

  CircleCropImageWithRing({
    required this.imageUrl,
    required this.cropSize,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 圆环
        CustomPaint(
          size: Size(cropSize, cropSize),
          painter: RingPainter(),
        ),
        // 圆形图片
        ClipPath(
          clipper: CircleClipper(cropSize: cropSize, offset: offset),
          child: Image.network(
            imageUrl,
            fit: BoxFit.none,
            alignment: Alignment(-offset.dx / cropSize, -offset.dy / cropSize),
          ),
        ),
      ],
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  final double cropSize;
  final Offset offset;

  CircleClipper({required this.cropSize, required this.offset});

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(cropSize / 2, cropSize / 2),
        radius: cropSize / 2,
      ));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green // 设置画笔颜色为绿色
      ..style = PaintingStyle.stroke // 填充样式为描边
      ..strokeWidth = 4.0; // 设置描边宽度

    double radius = size.width / 2;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), // 圆心坐标
      radius, // 半径
      paint, // 画笔
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}