import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_developer_test/styles.dart';

/// search input view
/// See [SearchInputStyle] for a number of predefined search available for dc
/// design applications.
class SearchInput extends StatelessWidget {
  String text;
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final SearchInputData inputData;

  SearchInput({
    Key? key,
    required this.hintText,
    required this.onSubmitted,
    required this.text,
    this.onChanged,
    required this.inputData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: text);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5.0, right: 5),
              decoration: BoxDecoration(
                  color: MyColor.Gray,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(color: inputData.borderColor, width: 1)),
              height: 57.0,
              child: TextField(
                  maxLines: 1,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  keyboardType: TextInputType.text,
                  controller: controller,
                  obscureText: false,
                  onSubmitted: onSubmitted,
                  onChanged: (text) {
                    onChanged!(text);
                  },
                  style: TextStyle(
                      color: MyColor.Title,
                      fontFamily: MyFont.Poppins,
                      fontSize: inputData.textSize,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: inputData.iconColor,
                      ),
                      suffixIcon:
                          text.length > 0 && inputData.cancelIcon != null
                              ? GestureDetector(
                                  onTap: () {
                                    text = "";
                                    controller.clear();
                                    onChanged!(text);
                                  },
                                  child: inputData.cancelIcon,
                                )
                              : null,
                      hintText: '$hintText',
                      hintStyle: TextStyle(
                          color: MyColor.Paragraph,
                          fontFamily: MyFont.Poppins,
                          fontSize: 14,
                          fontWeight: FontWeight.w500))))
        ]);
  }
}

/// a style data
class SearchInputData {
  final Color borderColor;
  final Color iconColor;
  final double textSize;
  final Icon? cancelIcon;

  const SearchInputData(
      {required this.borderColor,
      required this.iconColor,
      required this.textSize,
      this.cancelIcon});
}

/// for a number of predefined styles available for dc design applications.
class SearchInputStyle {
  static const MobileStyle = SearchInputData(
      iconColor: MyColor.Paragraph,
      textSize: 14,
      cancelIcon: Icon(
        Icons.cancel,
        color: MyColor.Paragraph,
      ),
      borderColor: Colors.transparent);

  static const WebDefaultStyle = SearchInputData(
      iconColor: Colors.black, textSize: 20, borderColor: Colors.transparent);
  static const WebActiveStyle = SearchInputData(
      iconColor: Colors.black, textSize: 20, borderColor: MyColor.Primary);
  static const WebErrorStyle = SearchInputData(
      iconColor: Colors.black, textSize: 20, borderColor: MyColor.Error);
}
