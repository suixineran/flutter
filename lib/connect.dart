// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'actual-target.dart';
import 'comp/video.dart';

class ConnectWidge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: MyCustomLayout(),
      ),
    );
  }
}

class MyCustomLayout extends StatefulWidget {
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
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // 创建一个每秒触发一次的定时器
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
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
          Container(
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
          VideoPlayerScreen(),

          //  进度条
          Container(
            margin: EdgeInsets.fromLTRB(
                10.0, 10.0, 10.0, 10.0), // 设置左、上、右、下边距分别为20、30、40、50像素
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // 设置圆角半径为10.0
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(49, 213, 45, 1),
                ), // 设置进度条颜色为红色
                backgroundColor: Colors.grey, // 设置进度条背景颜色为灰色
                value: percent, // 设置进度条的进度为50%
              ),
            ),
          ),

          // 连接状态的校验
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
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
                        width: 8, // 设置宽度为10像素
                        height: 8, // 设置高度为10像素
                        decoration: BoxDecoration(
                          color: Colors.grey, // 设置背景颜色为红色
                          shape: BoxShape.circle, // 设置形状为圆形
                        ),
                      ),
                    ),
                    Visibility(
                        visible: cameraStatue == 1,
                        child: SpinKitFadingCircle(
                          color: Color.fromRGBO(49, 213, 45, 1), // 可选，设置颜色
                          size: 20.0, // 可选，设置大小
                        )),
                    Visibility(
                        visible: cameraStatue == 2,
                        child: Icon(
                          Icons.warning,
                          color: Colors.red, // 设置图标颜色为红色
                          size: 18.0, // 设置图标大小为30像素
                        )),
                    Visibility(
                      visible: cameraStatue > 2,
                      child: Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 26.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0), // 设置所有方向的边距为16像素
                      child: Text(
                        'Camera connecting ... ',
                        style: TextStyle(
                          color: cameraStatue == 2
                              ? Color.fromRGBO(255, 73, 73, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 2,
                      child: Text(
                        'Ask for help',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          decoration: TextDecoration.underline, // 设置文字带下划线
                          decorationStyle:
                              TextDecorationStyle.solid, // 设置下划线样式为实线
                          fontWeight: FontWeight.bold, // 设置字体粗细为粗体
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
                      child: Container(
                        width: 8, // 设置宽度为10像素
                        height: 8, // 设置高度为10像素
                        decoration: BoxDecoration(
                          color: Colors.grey, // 设置背景颜色为红色
                          shape: BoxShape.circle, // 设置形状为圆形
                        ),
                      ),
                    ),
                    Visibility(
                        visible: cameraStatue == 5,
                        child: SpinKitFadingCircle(
                          color: Color.fromRGBO(49, 213, 45, 1), // 可选，设置颜色
                          size: 20.0, // 可选，设置大小
                        )),
                    Visibility(
                        visible: cameraStatue == 6,
                        child: Icon(
                          Icons.warning,
                          color: Colors.red, // 设置图标颜色为红色
                          size: 18.0, // 设置图标大小为30像素
                        )),
                    Visibility(
                      visible: cameraStatue > 6,
                      child: Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 26.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0), // 设置所有方向的边距为16像素
                      child: Text(
                        'Parameter checking ',
                        style: TextStyle(
                          color: cameraStatue == 6
                              ? Color.fromRGBO(255, 73, 73, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 6,
                      child: Text(
                        'Ask for help',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          decoration: TextDecoration.underline, // 设置文字带下划线
                          decorationStyle:
                              TextDecorationStyle.solid, // 设置下划线样式为实线
                          fontWeight: FontWeight.bold, // 设置字体粗细为粗体
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
                        width: 8, // 设置宽度为10像素
                        height: 8, // 设置高度为10像素
                        decoration: BoxDecoration(
                          color: Colors.grey, // 设置背景颜色为红色
                          shape: BoxShape.circle, // 设置形状为圆形
                        ),
                      ),
                    ),
                    Visibility(
                        visible: cameraStatue == 9,
                        child: SpinKitFadingCircle(
                          color: Color.fromRGBO(49, 213, 45, 1), // 可选，设置颜色
                          size: 20.0, // 可选，设置大小
                        )),
                    Visibility(
                        visible: cameraStatue == 10,
                        child: Icon(
                          Icons.warning,
                          color: Colors.red, // 设置图标颜色为红色
                          size: 18.0, // 设置图标大小为30像素
                        )),
                    Visibility(
                      visible: cameraStatue > 10,
                      child: Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 26.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0), // 设置所有方向的边距为16像素
                      child: Text(
                        'Target confirm',
                        style: TextStyle(
                          color: cameraStatue == 10
                              ? Color.fromRGBO(255, 73, 73, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cameraStatue == 10,
                      child: Text(
                        'Ask for help',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          decoration: TextDecoration.underline, // 设置文字带下划线
                          decorationStyle:
                              TextDecorationStyle.solid, // 设置下划线样式为实线
                          fontWeight: FontWeight.bold, // 设置字体粗细为粗体
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 10.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: const Color.fromARGB(255, 196, 183, 183),
                    width: 0.2),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  // 开始按钮
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cameraStatue > 12
                            ? Color.fromRGBO(49, 213, 45, 1)
                            : Colors.grey, // 根据状态设置颜色
                      ),
                      child: Center(
                        child: Text(
                          'START',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ), // 文字颜色始终为白色
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      10.0, 10.0, 1.0, 10.0), // 设置所有方向的边距为10像素
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    // data: IconThemeData(size: 20),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
