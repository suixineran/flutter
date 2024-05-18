import 'package:flutter/material.dart';  
import 'dart:async';  
  
void main() {  
  runApp(MyApp());  
}  
  
class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: Scaffold(  
        appBar: AppBar(  
          title: Text('上中下布局页面'),  
        ),  
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
  String topLeftText = "左侧文案";  
  String topRightText = "右侧文案";  
  int imageIndex = 1; // 初始图片索引  

  TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 16.0); 
  
  bool _isOffstage = false; // 初始状态为显示  

  bool _isLoading = false;  
  int _count = 0;  
  late Timer _timer; 
  
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
        // _count++;  
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
      topLeftText  += 'L';
      topRightText  += 'R';
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
        // 上部分  
        Row(  
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
          children: <Widget>[  
            if (_isLoading) CircularProgressIndicator(), 
            Text(topLeftText),  
            Text(topRightText),  
          ],  
        ),  



        // 中部分  
        Expanded( // 使用Expanded来填充剩余空间  
          child: Image(  
                image: AssetImage('../images/connent-$imageIndex.png'),  
                width: 100,  
                height: 100,  
              ),  
           ),  


     
       Row(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: <Widget>[  
                Offstage(  
                  offstage: _isOffstage,  
                  child: Text(  
                    '这是一段可以被显示或隐藏的文字。',  
                    style: TextStyle(fontSize: 20),  
                  ),  
                ),  
              RichText(  
                text: TextSpan(  
                  children: <TextSpan>[  
                    
                    TextSpan(  
                      text: 'You have pressed the button $_count times.',
                      // style: TextStyle(color: Colors.blue, fontSize: 20),  
                       style: _textStyle,  
                    ),  
                    TextSpan(  
                      text: '这是第二行红色的文字',  
                      style: _textStyle,  
                    ),  
                  ],  
                ),  
              ),  
            ],  
          ),  




   // 下部分  
        Row(  
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
          children: <Widget>[  
            
            ElevatedButton(  
              onPressed: _changeTopLeftText,  
              child: Text('切换文案'),  
            ),  
            ElevatedButton(  
              onPressed: _changeImage,  
              child: Text('切换图片'),  
            ),  
          ],  
        ),  

         Row(  
          mainAxisAlignment: MainAxisAlignment.center,  
          children: <Widget>[  
            ElevatedButton(  
              onPressed: _changeTextStyle,  
              child: Text('改变样式'),  
            ),  
            ElevatedButton(  
              onPressed: _toggleVisibility,  
              child: Text('控制显隐'),  
            ),  
          ],  
        ),  

        Row(  
          mainAxisAlignment: MainAxisAlignment.start,  
          children: <Widget>[  
            ElevatedButton(  
              onPressed: _toggleLoading,  
              child: Text('logidng效果'),  
            ),  
            ElevatedButton(  
              onPressed: _toggleVisibility,  
              child: Text('定时器'),  
            ),  
          ],  
        ),  


      
      ],  
    );  
  }  
}