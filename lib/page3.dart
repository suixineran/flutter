import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路由页面'),
      ),
          body: Center(
           child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 如果需要的话，可以居中显示列
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Page2()),
                    );
                  //  Navigator.pushNamed(context, '/page3');
                  },
                  child: Text('前往页面2'), // 修改了按钮文本以更准确地描述其功能
                ),
                SizedBox(height: 20), // 这是一个垂直间距，高度为20
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Page1()),
                    );
                    //  Navigator.pushNamed(context, '/page1');
                  },
                  child: Text('前往页面1'), // 修改了按钮文本以更准确地描述其功能
                ),
        ],
      ),
          )
    );
  }
}