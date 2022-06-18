import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingPageState();
  }
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        // 反转回初始状态时继续播放，实现无限循环
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 25),
        child: RotationTransition(
          alignment: Alignment.center,
          turns: _animationController,
          child: SizedBox(
            width: 240,
            height: 240,
            child: SvgPicture.asset(
              "assets/svg/state_loading.svg",
            ),
          ),
        ));
  }
}
