import 'package:flutter/material.dart';
import 'package:flutter_developer_test/styles.dart';

/// See [BubbleItems] for a number of predefined items available for dc
/// design applications.
class BubbleItem extends StatelessWidget {
  final BubbleItemData itemData;
  final String text;

  BubbleItem({
    Key? key,
    required this.text,
    required this.itemData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        color: itemData.background,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildChildren(),
      ),
    );
  }

  List<Widget> buildChildren() {
    List<Widget> children = [];
    if (itemData.leftIcon != null) {
      children.add(itemData.leftIcon!);
    }
    children.addAll([
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: itemData.textColor,
            fontFamily: MyFont.Poppins),
      )
    ]);
    return children;
  }
}

/// for a number of predefined items available for dc design applications.
class BubbleItems {
  static const WebGary = BubbleItemData(
      leftIcon: Icon(
        Icons.tag,
        color: MyColor.Primary,
      ),
      textColor: MyColor.Primary,
      background: MyColor.Gray);
  static const WebHover = BubbleItemData(
      leftIcon: Icon(
        Icons.tag,
        color: Colors.white,
      ),
      textColor: Colors.white,
      background: Color(0xff865CFF));
  static const WebActive = BubbleItemData(
      leftIcon: Icon(
        Icons.tag,
        color: Colors.white,
      ),
      textColor: Colors.white,
      background: MyColor.Primary);
  static const MobileGary =
      BubbleItemData(textColor: MyColor.Paragraph, background: MyColor.Gray);
  static const MobileActive =
      BubbleItemData(textColor: MyColor.Gray, background: MyColor.PrimaryDark);
}

/// item data
class BubbleItemData {
  final Icon? leftIcon;
  final Color textColor;
  final Color background;

  const BubbleItemData(
      {this.leftIcon, required this.textColor, required this.background});
}
