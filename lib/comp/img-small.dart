import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CropImageScreen extends StatefulWidget {
  final double x; // 选择的坐标
  final double y; // 选择的坐标

  const CropImageScreen({required this.x, required this.y});

  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  ui.Image? _image;
  late double w = 100; // 小图片的大小 正方形

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    ByteData data = await rootBundle.load('assets/0.png');
    Uint8List bytes = data.buffer.asUint8List();
    _image = await decodeImageFromList(bytes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: _image != null
            ? CustomPaint(
                painter: CropPainter(_image!, widget.x, widget.y, w),
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red,
                    //   width: 2.0,
                    // ),
                  ),
                  // width: _image!.width.toDouble(),
                  // height: _image!.height.toDouble(),
                   width: w,
                  height: w,
                ),
              )
            : CircularProgressIndicator(),
      );
  }
}

class CropPainter extends CustomPainter {
  final ui.Image image;
  final double x; // 坐标位置
  final double y; // 坐标位置
  final double w; // 小图片大小

  CropPainter(this.image, this.x, this.y, this.w,);

  @override
  void paint(Canvas canvas, Size size) {
    // final double cropWidth = 50;
    // final double cropHeight = 50;



    final Rect rect = Rect.fromLTWH(0, 0, w *2, w*2 ); // 要画多大的区域
    final Rect src = Rect.fromLTWH(x, y, w , w ,); // 要画照片的哪一部分
    canvas.drawImageRect(image, src, rect, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}