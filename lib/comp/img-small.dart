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
  late double w = 60; // 小图片的大小 正方形

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
    // print('w----$_image!.width.toDouble()');
    //  print('h----$_image!.height.toDouble()');
    return Center(

      //  child: CircleCropImageWithRing(
      //       imageUrl:  'images/target.png', // 替换成你自己的图片URL
      //       cropSize: 100.0, // 截图区域的直径
      //       offset: Offset(10, 50), // 截图区域在图片中的偏移量
      //       ringColor: Colors.green, // 圆环的颜色
            
      //     ),
      child: _image != null
          ? CustomPaint(
              painter: CropPainter(_image!, widget.x, widget.y, w),
              child: Container(
                decoration:  BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    ),
                // width: _image!.width.toDouble(),
                // height: _image!.height.toDouble(),

                width: w,
                height: w,
              ),
            )
          : const CircularProgressIndicator(),
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
    // final double cropWidth = 50;
    // final double cropHeight = 50;

    Paint paint = Paint()
      ..color = Colors.white // 设置画笔颜色为绿色
      ..style = PaintingStyle.stroke // 填充样式为描边
      ..strokeWidth = 3.0; // 设置描边宽度

    double radius = size.width / 2;


    print('X$x');
    print('Y$y');

    final Rect rect = Rect.fromLTWH(0, 0, w * 1, w * 1); // 要画多大的区域
    // final Rect src = Rect.fromLTWH(x, y, w*2.5, w*2.5 ,); // 要画照片的哪一部分
    final Rect src = Rect.fromLTWH(
      x,
      y,
      w * 1.21,
      w * 1.21,
    ); // 要画照片的哪一部分

    canvas.drawImageRect(image, src, rect, Paint());

     canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), // 圆心坐标
      radius, // 半径
      paint, // 画笔
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}







class CircleCropImageWithRing extends StatelessWidget {
  final String imageUrl;
  final double cropSize;
  final Offset offset;
  final Color ringColor;

  CircleCropImageWithRing({
    required this.imageUrl,
    required this.cropSize,
    required this.offset,
    required this.ringColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 圆环
        CustomPaint(
          size: Size(cropSize, cropSize),
          painter: RingPainter(offset: offset),
        ),
        // 圆形图片
        ClipPath(
          clipper: CircleClipper(cropSize: cropSize, offset: offset),
          child: Image.network(
            imageUrl,
            fit: BoxFit.none,
            alignment: Alignment(
              -offset.dx / (cropSize / 2),
              -offset.dy / (cropSize / 2),
            ),
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
  // final double ringWidth;
 final Offset offset;

  RingPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green // 设置画笔颜色
      ..style = PaintingStyle.stroke // 填充样式为描边
      ..strokeWidth = 4.0; // 设置描边宽度

    double radius = (size.width - 4) / 2;
    canvas.drawCircle(
      // Offset(size.width / 2, size.height / 2), // 圆心坐标
        Offset(size.width / 2, size.height / 2), // 圆心坐标
      // offset, // 圆心坐标
      radius, // 半径
      paint, // 画笔
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}