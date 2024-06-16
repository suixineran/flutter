import 'package:flutter/material.dart';



class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

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
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: _isSwitchedOn
                    ? Color.fromRGBO(255, 255, 255, 0.141)
                    : Color.fromRGBO(49, 213, 45, 0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    width: _isSwitchedOn? 60: 33,
                    height: 40,
                    margin: _isSwitchedOn
                        ? EdgeInsets.fromLTRB(9.0, 10.0, 0.0, 0.0)
                        : EdgeInsets.fromLTRB(3.0, 0.0, 10.0, 0.0), //左、上、右、下
                    child: _isSwitchedOn
                        ? Text(
                            '0:01:59',
                            style: TextStyle(color: Colors.white),
                          )
                        : Container(
                            width: 20,
                            height: 25,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('../images/switch-on1.png'),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('../images/switch-on2.png'),
                                  // width: 50, // 子组件的宽度
                                  height: 13, // 子组件的高度
                                ),
                              ],
                            ),
                          ),
                  ),



                  _isSwitchedOn
                      ? Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('../images/switch-off1.png'),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('../images/switch-off2.png'),
                                // width: 50, // 子组件的宽度
                                height: 15, // 子组件的高度
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(3.0), // 在所有方向上添加16个逻辑像素的内边距
                              ),
                              Image(
                                image: AssetImage('../images/switch-off2.png'),
                                // width: 5, // 子组件的宽度
                                height: 15, // 子组件的高度
                              ),
                            ],
                          ),
                        )
                      : Text(
                          '20:01:59',
                          style: TextStyle(color: Colors.white),
                        ),
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
