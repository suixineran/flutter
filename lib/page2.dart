import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('页面2'),
      // ),
      appBar: null, // 隐藏默认的 AppBar

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 在顶部和底部之间分配空间
          children: [
            // 顶部区域
            Expanded(
              child: Container(
                height: kToolbarHeight, // 可以根据需要调整高度
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios), // 返回箭头图标
                      iconSize: 24.0, // 图标大小
                      onPressed: () {
                        // 这里处理返回上一页的逻辑，例如使用 Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Page1()),
                        );
                      },
                      tooltip: '返回', // 可选的工具提示
                    ),
                    SizedBox(width: 4.0), // 左侧图标和文案之间的间距
                    // 左侧的文案
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '25.03',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // 右侧的文案
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '87/26',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 图片区域
            Expanded(
              flex: 4, // 可以根据需要调整flex值以改变区域大小
              child: Container(
                color: const Color.fromARGB(255, 13, 13, 13),
                height: 100, // 可以根据需要调整高度
                child: Image(
                  image: AssetImage('../images/connent-3.png'),
                  // width: 1000,
                  // height: 1000,
                ),
              ),
            ),
        



            // 成绩区
            Expanded(
              flex: 1, // 可以根据需要调整flex值以改变区域大小
              child: Row(
                children: [
                  Expanded(
                    // flex: 1,
                    child: Container(
                      color: Colors.black,
                      child: Center(child: Text('成绩区域')),
                    ),
                  ),
                ],
              ),
            ),



            // 底部区域
            Expanded(
              flex: 1, // 可以根据需要调整flex值以改变区域大小
              child: Row(
                children: [
                  // 中部第一个区域
                  Expanded(
                    flex: 1, // 分配等宽或根据需要调整
                    child: Container(
                      // color: Colors.lightGreen,
                      child: Center(child: Text('缩略图')),
                    ),
                  ),
                  // 中部第二个区域
                  Expanded(
                    flex: 1,
                    child: ToggleableButton(), // 这就是你之前定义的按钮
                  ),
                  // 中部第三个区域
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.orange,
                      child: MyHomePage(title: 'Switch Demo Home Page'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class ToggleableButton extends StatefulWidget {
  @override
  _ToggleableButtonState createState() => _ToggleableButtonState();
}

class _ToggleableButtonState extends State<ToggleableButton> {
  bool isEnabled = false; // 初始状态为可点击

  void toggleState() {
    setState(() {
      isEnabled = !isEnabled; // 切换状态
    });
  }

  @override
  Widget build(BuildContext context) {
    // 根据当前状态构建不同的按钮
    return GestureDetector(
      onTap: () => toggleState(), // 如果可点击，则切换状态
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isEnabled ? Colors.green : Colors.blue, // 根据状态设置颜色
        ),
        child: Center(
          child: Text(
            isEnabled ? 'pause' : 'start',
            style: TextStyle(color: Colors.white), // 文字颜色始终为白色
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSwitchedOn = false;

  void _onSwitchChanged(bool value) {
    setState(() {
      _isSwitchedOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // 'Is Switched On: ${_isSwitchedOn ? 'Yes' : 'No'}',
              'AR',
            ),
            Switch(
              value: _isSwitchedOn,
              onChanged: _onSwitchChanged,
            ),
          ],
        ),
      ),
    );
  }
}
