import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'page2.dart';
import 'page3.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(''),
        // ),
        appBar: null,
        body: MyCustomLayout(),
        // Counter(),
      ),
    );
  }
}

class MyCustomLayout extends StatefulWidget {
  @override
  _MyCustomLayoutState createState() => _MyCustomLayoutState();
}

class _MyCustomLayoutState extends State<MyCustomLayout> {
  String topLeftText = "New Training";
  String topRightText = "";
  int imageIndex = 1; // 初始图片索引

  TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 16.0);

  bool _isOffstage = false; // 初始状态为显示

  bool _isLoading = false;
  int _count = 0;
  late Timer _timer;

  int _colorIndex = 0;
  List<Color> _colors = [
    Colors.grey,
    Colors.red,
    Colors.green,
  ];

  // 定义一个布尔变量来控制图标的显示/隐藏
  bool showIcon = true;

  // 一个方法来切换图标的显示/隐藏状态
  void toggleIcon() {
    setState(() {
      showIcon = !showIcon;
    });
  }

  void _changeColor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _colors.length;
    });
    _changeImage();
  }

  bool isEnabled = false; // 初始状态为可点击

  void toggleState() {
    setState(() {
      isEnabled = !isEnabled; // 切换状态
    });
  }

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
    print('Timer ticked!');
    // 创建一个每秒触发一次的定时器
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        //   _count++;
        // _toggleLoading();
        // _toggleVisibility();
        // _changeImage();
      });
    });
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isOffstage = !_isOffstage; // 切换显示/隐藏状态
    });
  }

  void _changeTopLeftText() {
    setState(() {
      topLeftText += 'L';
      // topRightText  += 'R';
    });
  }

  void _changeImage() {
    setState(() {
      imageIndex = (imageIndex % 3) + 1; // 循环更新索引
    });
  }

  void _changeTextStyle() {
    setState(() {
      // 切换文字颜色和大小
      if (_textStyle.color == Colors.black) {
        _textStyle = TextStyle(color: Colors.red, fontSize: 24.0);
      } else {
        _textStyle = TextStyle(color: Colors.black, fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //  顶部
        Container(
          height: 50.0, // 设置容器的高度为100逻辑像素
          color: Colors.orange,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios), // 返回箭头图标
                iconSize: 24.0, // 图标大小
                onPressed: () {
                  // 这里处理返回上一页的逻辑，例如使用 Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page3()),
                  );
                },
                tooltip: '返回', // 可选的工具提示
              ),
              Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.orange,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          topLeftText,
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),

        //  图片
        Container(
          height: 400.0, // 设置容器的高度为100逻辑像素
          color: Color.fromARGB(255, 104, 32, 192),
          child: Expanded(
            // 使用Expanded来填充剩余空间
            // flex: 1,
            child: Image(
              image: AssetImage('../images/connent-$imageIndex.png'),
              width: 500,
              height: 400,
            ),
          ),
        ),

        // 文字
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    showIcon
                        ? SpinKitFadingCircle(
                            color: Colors.blue, // 可选，设置颜色
                            size: 20.0, // 可选，设置大小
                          )
                        : Container(),
                    Text(
                      'Camera connecting ... ',
                      style: TextStyle(color: _colors[_colorIndex]),
                    ),
                    Text(
                      'Ask for help',
                      style: TextStyle(
                        color: _colors[_colorIndex],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    showIcon
                        ? SpinKitFadingCircle(
                            color: Colors.blue, // 可选，设置颜色
                            size: 20.0, // 可选，设置大小
                          )
                        : Container(),
                    Text(
                      'Parameter check',
                      style: TextStyle(color: _colors[_colorIndex]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    showIcon
                        ? SpinKitFadingCircle(
                            color: Colors.blue, // 可选，设置颜色
                            size: 20.0, // 可选，设置大小
                          )
                        : Container(),
                    Text(
                      'Target confirm',
                      style: TextStyle(color: _colors[_colorIndex]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              // onPressed: _changeColor,
              onPressed: () {
                _changeColor();
              },
              child: Text('改变状态'),
            ),

// 添加一个按钮来切换图标的显示/隐藏状态
            ElevatedButton(
              onPressed: toggleIcon,
              child: Text('切换图标'),
            ),
            Expanded(   // 开始按钮
              flex: 1,
              child: GestureDetector(
                // onTap: () => toggleState(), // 如果可点击，则切换状态
                onTap: () async {  
                  print('11');
              // 等待2秒  
            
              await Future.delayed(Duration(seconds: 2)); 
                  toggleState();
                  print('22');
                  await Future.delayed(Duration(seconds: 2)); 
                  print('33');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page2()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isEnabled ? Colors.green : Colors.grey, // 根据状态设置颜色
                  ),
                  child: Center(
                    child: Text(
                      isEnabled ? 'start' : 'start',
                      style: TextStyle(color: Colors.white), // 文字颜色始终为白色
                    ),
                  ),
                ),
              ),
            ),

            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print('点击了刷新按钮');
              },
              iconSize: 20, // 设置图标大小为30
              color: Colors.grey, // 设置图标颜色为红色
            ),
          ],
        ),
      ],
    );
  }
}
