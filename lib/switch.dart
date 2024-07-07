import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged; // 添加回调函数参数

  const CustomSwitch({Key? key, this.onChanged}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSwitchedOn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _isSwitchedOn ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSwitchedOn = !_isSwitchedOn;
          _controller.fling(velocity: _isSwitchedOn ? 1.0 : -1.0);
          // 调用回调函数，并传递新的状态值
          widget.onChanged?.call(_isSwitchedOn);
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
              width: 130,
              // height: 40,
              decoration: BoxDecoration(
                color: _isSwitchedOn
                    ? Color.fromRGBO(255, 255, 255, 0.141)
                    : Color.fromRGBO(49, 213, 45, 0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _isSwitchedOn
                    ? [
                        // 暂停状态
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0), // 设置水平方向的边距为16.0
                          child: Text(
                            '0:01:59',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.fromLTRB(
                              3.0, 0.0, 3.0, 0.0), // 设置外边距设置左、上、右、下边
                          decoration: const BoxDecoration(
                            color: Colors.grey, // 设置背景颜色为红色
                            shape: BoxShape.circle, // 设置形状为圆形
                          ),
                          child: Image(
                            image: AssetImage('images/switch-off00.png'),
                            // width: 40, // 子组件的宽度
                            // height: 15, // 子组件的高度
                          ),
                        )
                      ]
                    : [
                        // 开的状态
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.fromLTRB(
                              3.0, 0.0, 3.0, 0.0), // 设置外边距设置左、上、右、下边
                          decoration: const BoxDecoration(
                            color: Colors.green, // 设置背景颜色为红色
                            shape: BoxShape.circle, // 设置形状为圆形
                          ),
                          child: Transform.scale(
                            scale: 0.4, // 缩放比例为0.5
                            child: Image(
                              image: AssetImage('images/switch-on0.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0), // 设置水平方向的边距为16.0
                          child: Text(
                            '20:01:59',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
