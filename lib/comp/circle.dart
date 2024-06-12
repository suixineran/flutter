import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleWidget extends StatelessWidget {
  final int score;
  final int numberTime;
  const CircleWidget(this.score, this.numberTime, {super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProgressPaint(
        score,
        numberTime,
      ), // 使用自定义的CirclePainter
      size: const Size(80, 80), // 设置绘制区域的大小
    );
  }
}

class ProgressPaint extends CustomPainter {
  ProgressPaint(
    this.score,
    this.numberTime,
  ) {
    //背景画笔
    paintBg0 = Paint()
      ..color = Colors.black
      ..strokeWidth = width
      ..isAntiAlias = true //是否开启抗锯齿
      ..style = PaintingStyle.fill; // 画笔风格，线

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

    // 分数的分割线
    paintLine = Paint()
      ..color = progressColor
      ..strokeWidth = width / 4
      ..isAntiAlias = true //是否开启抗锯齿
      ..style = PaintingStyle.stroke; // 画笔风格，线
  }

  final Color backgroundColor = Colors.grey;
  final Color progressColor = const Color.fromARGB(255, 33, 243, 54);
  final double width = 7;

  var paintBg;
  var paintProgress;
  var paintLine;
  var paintBg0;
  var score;
  var numberTime;

  @override
  void paint(Canvas canvas, Size size) {
    //半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    final centerPoint = Offset(size.width / 2, size.height / 2); //中心点
    double radius = size.width > size.height ? size.height / 2 : size.width / 2;
    canvas.drawCircle(centerPoint, radius, paintBg0);
    canvas.drawCircle(centerPoint, radius, paintBg);
    Rect rect = Rect.fromCircle(center: centerPoint, radius: radius);
    canvas.drawArc(rect, 11, math.pi * 2 * (score / (numberTime * 10)), false,
        paintProgress); // 为什么是11？？

    // 上面的数字
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: score.toString(),
          style: TextStyle(
            fontSize: 30,
            color: progressColor,
            fontWeight: FontWeight.w900,
          )),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset((size.width / 2 - textPainter.width / 2), (10)));

    // 分割线
    canvas.drawLine(Offset(0 + 2 + 10, (size.height / 2 + 4)),
        Offset(size.width - 10, size.height / 2 + 4), paintLine);

    // 下面的数字
    TextPainter textPainter2 = TextPainter(
      text: TextSpan(
          text: numberTime.toString(),
          style: TextStyle(
            fontSize: 15,
            color: progressColor,
          )),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout();
    textPainter2.paint(
        canvas,
        Offset(size.width / 2 - textPainter2.width / 2,
            size.height / 2 + textPainter2.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
