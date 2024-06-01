import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'video.dart';


void main() {
  runApp(MaterialApp(
    home: VideoPlayerScreen(),

    // 注册路由的方式没生效？？？
    // initialRoute: '/page1',  
    // routes: {  
    // '/page1': (context) => Page1(),  
    // '/page2': (context) => Page2(),  
    // '/page3': (context) => Page3(),  
    // // ... 其他路由  
    // },  
  ));
}