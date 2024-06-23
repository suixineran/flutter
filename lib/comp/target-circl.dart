//  选中点的子弹 红圈
// 主要要画在什么位置
import 'package:flutter/material.dart';
import 'dart:math' as math;

class targetCircleWidget extends StatelessWidget {
  
  const targetCircleWidget( {super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: targetCirclePaint(
       
      ), // 使用自定义的CirclePainter
      size: const Size(40, 40), // 设置绘制区域的大小
    );
  }
}

class targetCirclePaint extends CustomPainter {
  targetCirclePaint(
   
  ) {
 
    //背景画笔
    paintBg = Paint()
      ..color = backgroundColor
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..style = PaintingStyle.stroke; // 画笔风格，线

    //进度画笔
    paintProgress = Paint()
      ..color = progressColor
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..strokeCap = StrokeCap.round // 笔触设置为圆角
      ..style = PaintingStyle.stroke; // 画笔风格，线

  }

  final Color backgroundColor = Colors.grey; //rgb(255, 58, 58)
  final Color progressColor = const Color.fromRGBO(255, 0, 0, 1.0);
  final double width = 5;

  var paintBg;
  var paintProgress;
  

  @override
  void paint(Canvas canvas, Size size) {
    //半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    final centerPoint = Offset(size.width / 2, size.height / 2); //中心点
    double radius = size.width > size.height ? size.height / 2 : size.width / 2;
    // canvas.drawCircle(centerPoint, radius, paintBg0);
    canvas.drawCircle(centerPoint, radius, paintBg);
    Rect rect = Rect.fromCircle(center: centerPoint, radius: radius);
    canvas.drawArc(rect, 11, math.pi * 2 * (1), false,
        paintProgress); // 为什么是11？？
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
