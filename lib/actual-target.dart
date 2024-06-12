import 'package:flutter/material.dart';
import 'connect.dart';
import 'dart:math'; // 导入dart:math库
import 'comp/circle.dart';
import 'comp/video-small.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSwitchedOn = false;

  bool isEnabled = false; // 初始状态为可点击
  Offset _offset = const Offset(300.0, 0.0);

  late int num;
  late List<int> years;
  late List<int> valueList;
  late int selectedYear;

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
  String getPathForNumber(int number) {
    if (number >= 0 && number <= 4) {
      return 'images/score-r.png'; // 红色
    } else if (number >= 5 && number <= 7) {
      return  'images/score-y.png'; // 黄色
    } else if (number >= 8 && number <= 10) {
      return  'images/score-g.png'; // 绿色
    } else {
      return  'images/score-y.png'; // 默认情况下或其他情况下返回黑色
    }
  }

  void toggleState() {
    setState(() {
      isEnabled = !isEnabled; // 切换状态
    });
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      _isSwitchedOn = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _offset = const Offset(5.0, 320.0);
    num = 30;
    years = List.generate(num, (index) => index);
    valueList =
        List.generate(num, (index) => Random().nextInt(10) + 1); // 生成1到10的随机数字
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
                  height: 400, // 可以根据需要调整高度
                  child: const Image(
                    image: AssetImage('../images/connent-3.png'),
                    // width: 1000,
                    // height: 1000,
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
                scrollDirection: Axis.horizontal,
                itemCount: years.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        print('xxxxxxxx$index',);
                        selectedYear = years[index];
                      });
                    },
                    child: SizedBox(
                      width: 100, // 刻度的宽度
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(getPathForNumber(valueList[index])),
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                     valueList[index].toString(),
                                      style: TextStyle(
                                        color: getColorForNumber(
                                        valueList[index]),
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                          const SizedBox(height: 5), // 刻度线和年份的间距

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

            // 底部区域

            Row(
              children: [
                // 中部第一个区域

                Stack(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('../images/score-g.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        // valueList[index].toString(),
                        'test',
                        style: TextStyle(
                          fontSize: 20,
                          // color: getColorForNumber(
                          //     valueList[index]), // 根据数字获取颜色
                          //       fontSize: 20),
                          // 可以根据需要设置其他样式属性
                        ),
                      ),
                    ),
                  ],
                ),

                // 中部第二个区域
                GestureDetector(
                    onTap: () => toggleState(), // 如果可点击，则切换状态
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isEnabled ? Colors.green : Colors.blue, // 根据状态设置颜色
                      ),
                      child: Center(
                        child: Text(
                          isEnabled ? 'pause' : 'start',
                          style:
                              const TextStyle(color: Colors.white), // 文字颜色始终为白色
                        ),
                      ),
                    )),

                // 中部第三个区
                Container(
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
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //  浮动的视频窗口
      Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: Draggable(
          // 使用 Draggable Widget包裹视频播放器
          feedback: Container(
            // width: 200.0,
            // height: 100.0,
            // color: Color.fromARGB(255, 33, 119, 41),
            child: const Center(
              child: VideoPlayerScreenS(),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            print(velocity);
            print(offset);

            setState(() {
              _offset = offset;
            });
          },
          // 使用 Draggable Widget包裹视频播放器
          child: Container(
            // width: 200.0,
            // height: 150.0,
            color: const Color.fromARGB(255, 5, 5, 5),
            child: const Center(
              child: VideoPlayerScreenS(),
            ),
          ),
        ),
      ),
    ]);
  }
}
