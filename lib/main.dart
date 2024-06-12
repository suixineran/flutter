import 'package:flutter/material.dart';
import 'actual-target.dart';


void main() {
  runApp(const MaterialApp(
    // home: DynamicPositionExample(),
    // home: ConnectWidge(),
    home:Page2(),

    // 注册路由的方式没生效？？？
    // initialRoute: '/page1',  
    // routes: {  
    // '/page2': (context) => Page2(),  
    // // ... 其他路由  
    // },  
  ));
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Text with Background Image'),
//         ),
//         body: Center(
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('images/score-y.png'),
//                 // fit: BoxFit.cover,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'Hello World!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
