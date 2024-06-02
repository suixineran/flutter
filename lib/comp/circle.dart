import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProgressPaint(
        0.3, // 设置进度值，范围为0到1
        8, // 设置画笔宽度
        Colors.grey, // 设置背景画笔颜色
        const Color.fromARGB(255, 33, 243, 54), // 设置进度画笔颜色
      ), // 使用自定义的CirclePainter
      size: Size(100, 100), // 设置绘制区域的大小
    );
  }
}

class ProgressPaint extends CustomPainter {
  ProgressPaint(
      this.progress, //进度
      this.width, //画笔宽度
      this.backgroundColor, //背景画笔颜色
      this.progressColor) {
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

  final Color backgroundColor;
  final double progress;
  final Color progressColor;
  final double width;

  var paintBg;
  var paintProgress;

  @override
  void paint(Canvas canvas, Size size) {
    //半径，这里为防止宽高不一致，取较小值的一半作为半径大小
    double radius = size.width > size.height ? size.height / 2 : size.width / 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paintBg);
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, 0, progress, false, paintProgress);

     // 绘制文字
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: 'wwwwww', style: TextStyle(fontSize: 12)),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 + textPainter.height / 2));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// class CircleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: CircleProgressBar(50, 'Hello'), // 使用自定义的CirclePainter
//       size: Size(100, 100), // 设置绘制区域的大小
//     );
//   }
// }

// class CircleProgressBar extends CustomPainter {
//   late Paint _paintBackground;
//   late Paint _paintFore;
//   final double pi = 3.1415926;
//   var progress; //0-360
//   String text; // 要显示的文字

//   CircleProgressBar(this.progress, this.text) {
//     _paintBackground = Paint()
//       ..color = Colors.transparent
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5.0
//       ..isAntiAlias = true;
//     _paintFore = Paint()
//       ..color = Color.fromARGB(255, 8, 202, 21)
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0
//       ..isAntiAlias = true;
//   }

//   updateProgress(int pg) {
//     this.progress = pg;
//     print(progress);
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     //绘制流程
//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2,
//         _paintBackground);
//     Rect rect = Rect.fromCircle(
//       center: Offset(size.width / 2, size.height / 2),
//       radius: size.width / 2,
//     );
//     canvas.drawArc(
//         rect,
//         -pi / 2, //圆开始的位置（正上方）
//         360 * progress / 100 * 3.14 / 180,
//         false,
//         _paintFore);

//     // 绘制文字
//     TextPainter textPainter = TextPainter(
//       text: TextSpan(text: text, style: TextStyle(fontSize: 12)),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 + textPainter.height / 2));
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     //刷新布局的时候告诉Flutter是否需要重绘
//     return true;
//   }
// }
