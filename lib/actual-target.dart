import 'package:flutter/material.dart';
import 'connect.dart';
import 'dart:math'; // 导入dart:math库
import 'comp/circle.dart';
import 'comp/video-small.dart';
import 'comp/switch.dart';
import 'comp/img-small.dart';
import 'comp/target-circl.dart';
import 'dart:async';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: null,
        body: MyHomePage(title: 'xxx'),
      ),
    );
  }
}

class DataPoint {
  final int index;
  final String id;
  final double x;
  final double y;

  DataPoint(this.index, this.id, this.x, this.y);
}

List<DataPoint> generateRandomDataPoints(
    int count, double minX, double maxX, double minY, double maxY) {
  final random = Random();
  final dataPoints = <DataPoint>[];

  for (int i = 0; i < count; i++) {
    // 假设ID是基于索引的简单字符串，但你可以根据需要生成更复杂的ID
    String id = 'ID_$i';
    // double randomX = minX + random.nextDouble() * (maxX - minX);
    // double randomY = minY + random.nextDouble() * (maxY - minY);
    double randomX = minX + i * 10;
    double randomY = minY + i * 10;

    dataPoints.add(DataPoint(i, id, randomX, randomY));
  }

  return dataPoints;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _centerIndex = 0;
  Timer? _scrollTimer;


  bool isEnabled = false; // 初始状态为可点击
  // Offset _offset = const Offset(300.0, 0.0);

  late int num;
  late List<int> years; //坐标轴
  late List<int> valueList; // 坐标轴的数据
  late int selectedTarget; // 选中的数据是多少
  int selectedIndex = 1000; //选中的索引

  late DataPoint targetPoint; // 选中的数据是多少
  late List<DataPoint> points; // 整体的数据

  double left = 0; // 选中初始左边距离为
  double top = 0; // 选中初始顶部距离为

  bool isSwitchedOn = true; // 开关的状态
  double _scale = 1.0;
  double _width = 62.0; // 成绩区域的宽度 总宽度430  每个86 展示5个

  final GlobalKey _imageKey = GlobalKey();
  Offset _dragOffset = Offset.zero;

  void _getImageInfo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _imageKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final size = renderBox.size; // 获取图片的大小
        final position = renderBox.localToGlobal(Offset.zero); // 获取图片的位置坐标

      } else {
      }
    });
  }

  //  接受子组件的传值
  void handleSwitchChanged(bool newValue) {
    setState(() {
      isSwitchedOn = newValue;
      // 在这里处理开关状态的变化，例如更新 UI 或发送数据
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTarget = -1;
    _dragOffset = const Offset(-100.0, 430.0);
    num = 30;
    years = List.generate(num, (index) => index);
    valueList =
        List.generate(num, (index) => Random().nextInt(10) + 1); // 生成1到10的随机数字

    // 假设我们想要生成10个数据点，X和Y坐标都在0到100的范围内
    points = generateRandomDataPoints(num, 0.0, 0.0, 0, 400.0);

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    _scrollTimer?.cancel();

    //停止滚动后
    _scrollTimer = Timer(const Duration(milliseconds: 300), () {
      int centerIndex = (_scrollController.offset / (_width)).round();
      setState(() {
        _centerIndex = centerIndex;
      });
      _scrollController.animateTo(
        _centerIndex * (_width),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // 根据数字返回颜色
  Color getColorForNumber(int number) {
    if (number >= 0 && number <= 4) {
      return Colors.red; // 红色
    } else if (number >= 5 && number <= 7) {
      return Colors.yellow; // 黄色
    } else if (number >= 8 && number <= 10) {
      return Colors.green; // 绿色
    } else {
      return Colors.black; // 默认情况下或其他情况下返回黑色
    }
  }

// 成绩的背景图
  String getPathForNumber(int number) {
    if (number >= 0 && number <= 4) {
      return 'images/score-r.png'; // 红色
    } else if (number >= 5 && number <= 7) {
      return 'images/score-y.png'; // 黄色
    } else if (number >= 8 && number <= 10) {
      return 'images/score-g.png'; // 绿色
    } else {
      return 'images/score-y.png'; // 默认情况下或其他情况下返回黑色
    }
  }

  void toggleState() {
    setState(() {
      isEnabled = !isEnabled; // 切换状态
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        color: Colors.black, // 设置背景色
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween, // 在顶部和底部之间分配空间
          children: <Widget>[
            // 顶部区域
            //  顶部
            const SizedBox(
              height: 60.0,
              child: Center(
                child: Text(
                  "Shoot Master",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),

            // 图片区域

            Stack(
              children: <Widget>[
                Container(
                  color: const Color.fromARGB(255, 13, 13, 13),
                  height: 490, // 可以根据需要调整高度
                  child: Transform.scale(
                    scale: 1.0, // 放大倍数
                    child: Image.asset(
                      'images/target.png', // 替换为你的图片路径
                      key: _imageKey,
                    ),
                  ),
                ),
                const Positioned(
                  top: 20,
                  right: 20,
                  child: CircleWidget(20, 10),
                ),
              ],
            ),

            // 成绩区
            SizedBox(
              // color: Color.fromARGB(255, 220, 22, 22),
              height: 100, // 可以根据需要调整高度
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: years.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // print(index);
                        selectedTarget = years[index];
                        selectedIndex = index;
                        // print(selectedTarget);

                        // 打印数据点以验证
                        points.forEach((point) {
                          if (point.index == index) {
                            targetPoint = point;
                            left = targetPoint.x;
                            top = targetPoint.y;
                          }
                        });
                        print('left$left');
                        print('top$top');
                        
                        // _getImageInfo();
                      });
                    },
                    child: SizedBox(
                      width: _width, // 刻度的宽度
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.scale(
                            scale: selectedIndex == index ? 1.3 : 1.0, // 应用缩放
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            getPathForNumber(valueList[index])),
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        valueList[index].toString(),
                                        style: TextStyle(
                                          color: getColorForNumber(
                                              valueList[index]),
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 6.0), // 设置上边距
                          ),

                          Container(
                            height: 2, // 刻度线的高度
                            color: Colors.grey, // 刻度线的颜色
                          ),
                          Container(
                            width: 2,
                            height: 5,
                            color: Colors.grey, // 刻度线的颜色
                          ),

                          const SizedBox(height: 5), // 刻度线和索引的间距

                          Text(
                            years[index].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white, // 刻度线的颜色
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5.0), // 在所有方向上添加16个逻辑像素的内边距
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 1,
                  height: 20,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Color.fromARGB(255, 245, 246, 245),
                  //     width: 0.5, // 设置外边框的宽度
                  //   ),
                  // ),
                  child: const Text(
                    '',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSwitch(onChanged: handleSwitchChanged),
                ],
              ),
              Positioned(
                right: 25, // 距离屏幕左边的距离
                bottom: 10, //
                child: Container(
                  // margin: EdgeInsets.fromLTRB(60.0, 0.0, 30.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConnectWidge()),
                      );
                    },
                    child: const Text(
                      'FINISH',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),

      // 选中的子弹效果
      Visibility(
          visible: selectedTarget != -1, // 一个布尔值，决定是否显示 widget
          child: Positioned(
              left: left + 51, // 动态设置左边距离
              top: top + 60, // 动态设置顶部距离

              child: isSwitchedOn
                  ? targetCircleWidget() //红圈
                  : CropImageScreen(x: left * 2.41, y: top * 2.41)) //放大的区域
          ),

      //  浮动的视频窗口
      // Positioned(
      //   child: GestureDetector(
      //     onPanUpdate: (DragUpdateDetails details) {
      //       setState(() {
      //         _dragOffset += details.delta;
      //         print(details.delta);
      //       });
      //     },
      //     child: Transform.translate(
      //       offset: _dragOffset,
      //       child: VideoPlayerScreenS(),
      //     ),
      //   ),
      // ),
    ]);
  }
}
