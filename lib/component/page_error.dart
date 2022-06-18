import 'package:flutter/material.dart';
import 'package:flutter_developer_test/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            height: 240,
            child: SvgPicture.asset(
              "assets/svg/state_error.svg",
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            "Aaaah! \nSomething went wrong",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: MyColor.Title,
                height: 1.08,
                fontFamily: MyFont.Poppins),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Brace yourself till we get the error fixed.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyColor.Paragraph,
                height: 1.85,
                fontFamily: MyFont.Poppins),
          ),
          Text(
            "You may also refresh the page \nor try again later.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: MyColor.Paragraph,
                height: 1.85,
                fontFamily: MyFont.Poppins),
          )
        ],
      ),
    );
  }
}
