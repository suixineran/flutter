import 'package:flutter/material.dart';
import 'dart:math';


class DynamicPositionExample extends StatefulWidget {
  @override
  _DynamicPositionExampleState createState() => _DynamicPositionExampleState();
}

class _DynamicPositionExampleState extends State<DynamicPositionExample> {
  GlobalKey _imageKey = GlobalKey();
  double left = 0; // 初始左边距离为
  double top = 0; // 初始顶部距离为

  void updatePosition() {
    setState(() {
      // 根据需要更新左边距离和顶部距离
      var random = Random();
      double imageWidth =
          (_imageKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .width;
      double imageHeight =
          (_imageKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      int w = imageWidth.toInt();
      int h = imageHeight.toInt();
      int randomNumber = random.nextInt(w); // 生成一个 0 到 99 之间的随机整数
      int randomNumber2 = random.nextInt(h); // 生成一个 0 到 99 之间的随机整数
      left = randomNumber.toDouble();
      top = randomNumber2.toDouble();
    });
  }

  // _DynamicPositionExampleState({required this.x, required this.y});

  @override

  // Widget build(BuildContext context) {

  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // 在这里，你可以获取到Stack的整体大小
      double stackWidth = constraints.maxWidth;
      double stackHeight = constraints.maxHeight;
      print(stackWidth);
      print(stackHeight);
      return Container(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Image.asset('../assets/0.png',
                    // width: 300,
                    // height: 300,
                    key: _imageKey), // 大图
                Positioned(
                  // left: x, // 动态设置左边距离
                  // top: y, // 动态设置顶部距离
                  left: left, // 动态设置左边距离
                  top: top, // 动态设置顶部距离
                  child: Image.asset(
                    'assets/0601.jpeg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ), // 小图
                ),
              ],
            ),
            Text('显示的坐标位置 $left, $top'), // 第三个子部件，显示一段文字
            RawMaterialButton(
              onPressed: () {
                // print('onPressed',x, y);
                updatePosition();
              },
              child: Text('Update Position'),
            ),
          ],
        ),
      );
    });
  }
}
