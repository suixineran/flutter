import 'package:flutter/material.dart';
import 'actual-target.dart';
import 'comp/img.dart';
import 'connect.dart';


void main() {
  runApp(const MaterialApp(
    // home: DynamicPositionExample(),
    home: ConnectWidge(),
    // home:Page2(),

    // 注册路由的方式没生效？？？
    // initialRoute: '/page1',  
    // routes: {  
    // '/page2': (context) => Page2(),  
    // // ... 其他路由  
    // },  
  ));
}
