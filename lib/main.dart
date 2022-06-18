import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_developer_test/pages/home/page.dart';
import 'package:flutter_developer_test/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  checkPlatform();

  runApp(MyApp());
}

void checkPlatform() {
  if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
    throw "this platform is not support";
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DC',
      home: MySplashPage(),
    );
  }
}

class MySplashPage extends StatefulWidget {
  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColor.Primary,
        child: Center(
          child: Container(
              height: 527,
              width: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 38,
                    width: 71,
                    child: SvgPicture.asset(
                      "assets/svg/logo_dc_text.svg",
                      color: Color(0xffffffff),
                    ),
                  ),
                  SizedBox(
                    height: 63,
                  ),
                  Text(
                    "Flutter Interview Test",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.33,
                        fontFamily: MyFont.Poppins),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Text(
                    "Lorem Lorem Lorem Lorem",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.33,
                        fontFamily: MyFont.Poppins),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Lorem more lorem and more lorem",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.85,
                          fontFamily: MyFont.Poppins),
                    ),
                  ),
                  Spacer(),
                ],
              )),
        ));
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();

    // used fish_redux
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage().buildPage(null))));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
