// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'actual-target.dart';
import 'comp/video.dart';

class ConnectWidge extends StatelessWidget {
  const ConnectWidge({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: null,
        body: MyCustomLayout(),
      ),
    );
  }
}

class MyCustomLayout extends StatefulWidget {
  const MyCustomLayout({super.key});

  @override
  _MyCustomLayoutState createState() => _MyCustomLayoutState();
}

class _MyCustomLayoutState extends State<MyCustomLayout> {
  late Timer _timer;
  double percent = 0.0;

  // 状态 0 1 2 3  初始 连接中 失败 成功
  // 相机监测状态
  int cameraStatue = 0;
  // 参数监测状态
  int paramStatue = 0;
  // 靶子监测状态
  int targetStatue = 0;

  @override
  void initState() {
    super.initState();
    // 在组件状态初始化时启动定时器
    _startTimer();
  }

  @override
  void dispose() {
    // 在组件被销毁时取消定时器，防止内存泄漏
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    // 创建一个每秒触发一次的定时器
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        cameraStatue++;
        percent += 0.09;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // 设置背景色
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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

          // 视频部分
          const VideoPlayerScreen(),

          //  进度条
          Container(
            margin: const EdgeInsets.fromLTRB(
                10.0, 10.0, 10.0, 10.0), // 设置左、上、右、下边距分别为20、30、40、50像素
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // 设置圆角半径为10.0
              child: LinearProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(49, 213, 45, 1),
                ), // 设置进度条颜色为红色
                backgroundColor: Colors.grey, // 设置进度条背景颜色为灰色
                value: percent, // 设置进度条的进度为50%
              ),
            ),
          ),

          // 连接状态的校验
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              
              children: <Widget>[
            
                // 相机
                Row(
                  children: [
                    
                    Visibility(
                      visible: cameraStatue == 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 12.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 1,
                      child: Container(
                        width: 20.0, // 设置Container的宽度
                        height: 20.0, // 设置Container的高度
                        child: SpinKitFadingCircle(
                          color: Color.fromRGBO(49, 213, 45, 1),
                          size: 20.0, // 设置SpinKitFadingCircle的大小
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 2,
                      child: Container(
                        width: 20, // 设置宽度为10像素
                        height: 20, // 设置高度为10像素

                        child: Icon(
                          Icons.warning,
                          color: Colors.red, // 设置图标颜色为红色
                          size: 20.0, // 设置图标大小为30像素
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue > 2,
                      child: Container(
                        width: 20, // 设置宽度为10像素
                        height: 20, // 设置高度为10像素

                        child: Icon(
                          Icons.done,
                          size: 22.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0), // 设置所有方向的边距为16像素
                      child: Text(
                        cameraStatue == 2
                            ? 'Camera connecting failed '
                            : (cameraStatue == 1
                                ? 'Camera connecting ...'
                                : (cameraStatue == 0
                                    ? 'Camera connect'
                                    : 'Camera connected')),
                        style: TextStyle(
                          color: cameraStatue == 2
                              ? const Color.fromRGBO(255, 73, 73, 1)
                              : (cameraStatue == 0
                                  ? Colors.grey
                                  : const Color.fromRGBO(255, 255, 255, 1)),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 2,
                      child: const Text(
                        'Ask for help',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          decoration: TextDecoration.underline, // 设置文字带下划线
                           decorationColor: Colors.white, // 设置下划线的颜色
            decorationThickness: 2.0, // 设置下划线的厚度
                        
                        ),
                      ),
                    ),
                  ],
                ),

                // 参数
                Row(
                  children: [
                    Visibility(
                      visible: cameraStatue < 5,
                      // visible: true,
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 12.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 5,
                      child: Container(
                        width: 20.0, // 设置Container的宽度
                        height: 20.0, // 设置Container的高度
                        child: SpinKitFadingCircle(
                          color: Color.fromRGBO(49, 213, 45, 1),
                          size: 20.0, // 设置SpinKitFadingCircle的大小
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 6,
                      child: Container(
                        width: 20, // 设置宽度为10像素
                        height: 20, // 设置高度为10像素

                        child: Icon(
                          Icons.warning,
                          color: Colors.red, // 设置图标颜色为红色
                          size: 20.0, // 设置图标大小为30像素
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue > 6,
                      child: Container(
                        width: 20, // 设置宽度为10像素
                        height: 20, // 设置高度为10像素

                        child: Icon(
                          Icons.done,
                          size: 22.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0), // 设置所有方向的边距为16像素
                      child: Text(
                        cameraStatue == 6
                            ? 'Parameter checking failed '
                            : (cameraStatue == 5
                                ? 'Parameter checking ...'
                                : (cameraStatue < 5
                                    ? 'Parameter check'
                                    : 'Parameter checked')),
                        style: TextStyle(
                          color: cameraStatue == 6
                              ? const Color.fromRGBO(255, 73, 73, 1)
                              : (cameraStatue < 5
                                  ? Colors.grey
                                  : const Color.fromRGBO(255, 255, 255, 1)),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 6,
                      child: const Text(
                        'Ask for help',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          decoration: TextDecoration.underline, // 设置文字带下划线
                          decorationColor: Colors.white, // 设置下划线的颜色
            decorationThickness: 2.0, // 设置下划线的厚度
                        ),
                      ),
                    ),
                  ],
                ),

                // 靶子
                Row(
                  children: [
                    Visibility(
                      visible: cameraStatue < 9,
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 12.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 9,
                      child: Container(
                        width: 20.0, // 设置Container的宽度
                        height: 20.0, // 设置Container的高度
                        child: SpinKitFadingCircle(
                          color: Color.fromRGBO(49, 213, 45, 1),
                          size: 20.0, // 设置SpinKitFadingCircle的大小
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 10,
                      child: Container(
                        width: 20, // 设置宽度为10像素
                        height: 20, // 设置高度为10像素

                        child: Icon(
                          Icons.warning,
                          color: Colors.red, // 设置图标颜色为红色
                          size: 20.0, // 设置图标大小为30像素
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue > 10,
                      child: Container(
                        width: 20, // 设置宽度为10像素
                        height: 20, // 设置高度为10像素

                        child: Icon(
                          Icons.done,
                          size: 22.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0), // 设置所有方向的边距为16像素
                      child: Text(
                        cameraStatue == 10
                            ? 'Target confirm Failed '
                            : (cameraStatue == 9
                                ? 'Target confirming ...'
                                : (cameraStatue < 9
                                    ? 'Target confirm'
                                    : 'Target confirmed')),
                        style: TextStyle(
                          color: cameraStatue == 10
                              ? const Color.fromRGBO(255, 73, 73, 1)
                              : (cameraStatue < 9
                                  ? Colors.grey
                                  : const Color.fromRGBO(255, 255, 255, 1)),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 10,
                      child: const Text(
                        'Ask for help',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          decoration: TextDecoration.underline, // 设置文字带下划线
                          decorationColor: Colors.white, // 设置下划线的颜色
            decorationThickness: 2.0, // 设置下划线的厚度
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 10.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color.fromARGB(255, 196, 183, 183), width: 0.2),
              ),
            ),
          ),

          Stack(children: [
            GestureDetector(
                onTap: () async {
                  if (cameraStatue > 12) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Page2()),
                    );
                  } else {
                    print('不能使用');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cameraStatue > 12
                              ? const Color.fromRGBO(49, 213, 45, 1)
                              : Colors.grey, // 根据状态设置颜色
                        ),
                        child: const Center(
                          child: Text(
                            'START',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ), // 文字颜色始终为白色
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Positioned(
              right: 10, // 距离屏幕左边的距离
              bottom: 10, // 距离屏幕底部的距离
              child: Container(
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    print('点击了刷新按钮');
                    setState(() {
                      cameraStatue = 0;
                      percent = 0;
                    });
                  },
                  iconSize: 30, // 设置图标大小为30
                  color: Colors.grey, // 设置图标颜色为红色
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
