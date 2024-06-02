import 'package:flutter/material.dart';
import 'dart:math'; // 导入dart:math库

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TimeLine(),
//     );
//   }
// }

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  late int num;
  late List<int> years;
  late List<int> valueList;
  late int selectedYear;

   // 根据数字返回颜色  
  Color getColorForNumber(int number) {  
    if (number >= 0 && number <= 4) {  
      return Colors.red; // 红色  
    } else if (number >= 5 && number <= 7) {  
      return Colors.yellow; // 黄色  
    } else if (number >= 8 && number <= 10) {  
      return Colors.green; // 绿色  
    } else {  
      return Colors.black; // 默认情况下或其他情况下返回黑色  
    }  
  }  

  @override
  void initState() {
    super.initState();
    num = 30;
    years = List.generate(num, (index) => index);
    valueList =
        List.generate(num, (index) => Random().nextInt(10) + 1); // 生成1到10的随机数字
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Time Line'),
      // ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: years.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                print('xxxxxxxx');
                selectedYear = years[index];
              });
            },
            child: Container(
              width: 55, // 刻度的宽度
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    valueList[index].toString(),
                    style: TextStyle(
                      color: getColorForNumber(valueList[index]), // 根据数字获取颜色 
                      fontSize: 20),
                    
                  ),
                  Container(
                    height: 2, // 刻度线的高度
                    color: Colors.grey, // 刻度线的颜色
                  ),
                   Container(
                    width: 2,
                    height: 5,
                    color: Colors.grey, // 刻度线的颜色
                  ),
                  SizedBox(height: 5), // 刻度线和年份的间距

                  Text(
                    years[index].toString(),
                    style: TextStyle(
                      fontSize: 16,
                    color: Colors.black, // 刻度线的颜色
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
