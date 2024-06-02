import 'package:flutter/material.dart';
import 'connect.dart';
import 'actual-target.dart';
import 'comp/video.dart';
import 'comp/img.dart';


void main() {
  runApp(MaterialApp(
    // home: DynamicPositionExample(),
    home: ConnectWidge(),

    // 注册路由的方式没生效？？？
    // initialRoute: '/page1',  
    // routes: {  
    // '/page2': (context) => Page2(),  
    // // ... 其他路由  
    // },  
  ));
}