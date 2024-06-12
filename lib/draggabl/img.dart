import 'package:flutter/material.dart';

class RestrictedDragAreaWidget extends StatefulWidget {
  const RestrictedDragAreaWidget({super.key});

  @override
  _RestrictedDragAreaWidgetState createState() => _RestrictedDragAreaWidgetState();
}

class _RestrictedDragAreaWidgetState extends State<RestrictedDragAreaWidget> {
  double offsetX = 0.0;
  double offsetY = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          double newX = offsetX + details.delta.dx;
          double newY = offsetY + details.delta.dy;

          // 检查是否超出了指定区域，这里假设限制在 x 轴 [-100, 100]，y 轴 [-100, 100] 的范围内
          if (newX >= -100 && newX <= 100) {
            offsetX = newX;
          }
          if (newY >= -100 && newY <= 100) {
            offsetY = newY;
          }
        });
      },
      child: Container(
        color: Colors.grey,
        child: Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: Container(
            width: 50.0,
            height: 50.0,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: Scaffold(body: RestrictedDragAreaWidget())));