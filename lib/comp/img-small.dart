import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CropImageScreen extends StatefulWidget {
  final double x; // 选择的坐标
  final double y; // 选择的坐标

  const CropImageScreen({super.key, required this.x, required this.y});

  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  ui.Image? _image;
  late double w = 65; // 小图片的大小 正方形

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    ByteData data = await rootBundle.load('images/target.png');
    Uint8List bytes = data.buffer.asUint8List();
    _image = await decodeImageFromList(bytes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _image != null
          ? Stack(
      alignment: Alignment.center,
      children: [
        // 圆环
        CustomPaint(
          size: Size(w, w),
          painter: RingPainter(),
        ),
        // 圆形图片
         CustomPaint(
              painter: CropPainter(_image!, widget.x, widget.y, w),
              child: Container(
                // decoration:  BoxDecoration(
                //     border: Border.all(
                //       color: Colors.white,
                //       width: 2.0,
                //     ),
                //     ),

                width: w,
                height: w,
              ),
            )
      ],
    ): const CircularProgressIndicator(),
          
    );
  }
}

class CropPainter extends CustomPainter {
  final ui.Image image;
  final double x; // 坐标位置
  final double y; // 坐标位置
  final double w; // 小图片大小

  CropPainter(
    this.image,
    this.x,
    this.y,
    this.w,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, w * 1, w * 1); // 要画多大的区域
    final Rect src = Rect.fromLTWH(
      x,
      y,
      w * 1.21,
      w * 1.21,
      
    ); // 要画照片的哪一部分
    // canvas.drawImageRect(image, src, rect, Paint());


 // 创建一个Path对象  
    final Path path = Path();  
    // 添加一个圆形到Path中，这里假设我们想要裁剪出一个居中的圆形  
    final double radius = size.width / 2.0; // 假设我们想要一个正方形区域中的最大圆形  
    path.addOval(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 2 * radius, height: 2 * radius));  
  
    // 使用clipPath来裁剪Canvas  
    canvas.clipPath(path);  
  
    // 现在Canvas已经被裁剪成圆形了，你可以在这里绘制任何东西，它都只会显示在圆形区域内  
    final Paint paint = Paint()..color = Colors.blue;  

     canvas.drawImageRect(image, src, rect, Paint());

    // canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint); // 绘制一个蓝色的矩形，但它只会在圆形区域内显示  





  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white // 设置画笔颜色为绿色
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