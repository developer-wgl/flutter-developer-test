import 'package:flutter/material.dart';
import 'package:flutter_developer_test/styles.dart';

/// languages listview item view
class LanguageItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final String? url;
  final String? category;

  LanguageItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.url,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Color(0xffEDF2F7), width: 1.5)),
            child: image == null ? Icon(Icons.error) : Image.network(image!), /// this Image.network is not well on web. use CanvasKit build is ok.
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${title!}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: MyColor.Title,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: MyFont.Poppins),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${description!}",
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: MyColor.Paragraph,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: MyFont.Poppins),
                    ))
              ],
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.route,
            color: Color(0xffEDF2F7),
          ),
        ],
      ),
    );
  }
}
