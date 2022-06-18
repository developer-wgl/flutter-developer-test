import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_developer_test/component/bubble.dart';
import 'package:flutter_developer_test/component/language_list_item.dart';
import 'package:flutter_developer_test/component/page_error.dart';
import 'package:flutter_developer_test/component/page_loading.dart';
import 'package:flutter_developer_test/component/page_not_found.dart';
import 'package:flutter_developer_test/component/search_input.dart';
import 'package:flutter_developer_test/pages/home/action.dart';
import 'package:flutter_developer_test/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

Widget buildMobileView(
    HomeState state, Dispatch dispatch, ViewService viewService) {
  return MyHomeWidget(
    state: state,
    dispatch: dispatch,
    viewService: viewService,
  );
}

/// mobile HomePage
class MyHomeWidget extends StatefulWidget {
  final ViewService viewService;

  final HomeState state;

  final Dispatch dispatch;

  MyHomeWidget({
    required this.state,
    required this.dispatch,
    required this.viewService,
  });

  @override
  State<StatefulWidget> createState() {
    return _MyHomeWidgetState();
  }
}

class _MyHomeWidgetState extends State<MyHomeWidget> {
  Dispatch get _dispatch => widget.dispatch;

  HomeState get _state => widget.state;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        color: _state.contentState == PageContentState.Error
            ? MyColor.Error
            : MyColor.Primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: statusBarHeight,
              child: SafeArea(
                top: false,
                bottom: false,
                child: Text(""),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 24),
                child: SearchInput(
                  hintText: _state.searchInputHintText,
                  inputData: SearchInputStyle.MobileStyle,
                  onSubmitted: (text) {
                    print('"test: ' + text);
                    setState(() {
                      if (text.isEmpty)
                        _state.contentState = PageContentState.NotFound;
                      _state.searchInputText = text;
                      _dispatch(HomeActionCreator.querySearchResult(text));
                    });
                  },
                  onChanged: (text) {
                    if (text.isEmpty)
                      _state.contentState = PageContentState.NotFound;
                    _state.searchInputText = text;
                  },
                  text: _state.searchInputText,
                )),
            Container(
              height: 38,
              margin: EdgeInsets.only(bottom: 24),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: buildBubbleTagsList(),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    border: Border.all(color: MyColor.Gray, width: 1)),
                child: buildPageContent(),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// page mid content state change
  Widget buildPageContent() {
    if (_state.contentState == PageContentState.Loading) return LoadingPage();
    if (_state.contentState == PageContentState.Error || _state.data == null)
      return ErrorPage();
    if (_state.contentState == PageContentState.NotFound ||
        _state.data!.length == 0) return NotFoundPage();

    // push languages items
    return ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int position) {
          return position == _state.data!.length
              ? Container(
                  height: 345,
                  alignment: Alignment.center,
                  child: Text(
                    "${_state.data!.length} Items",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: MyColor.Paragraph,
                        fontFamily: MyFont.Poppins),
                  ),
                )
              : Container(
                  margin:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: LanguageItem(
                        image: _state.data![position].image,
                        title: _state.data![position].title,
                        description: _state.data![position].description,
                        url: _state.data![position].url,
                        category: _state.data![position].category),
                    onPressed: () {
                      launchUrl(Uri.parse(_state.data![position].url!),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            child: Divider(height: 2, color: MyColor.Gray),
          );
        },
        itemCount: _state.data!.length + 1);
  }

  /// tags bubble
  List<Widget> buildBubbleTagsList() {
    List<Widget> tags = [];
    tags.add(SizedBox(
      width: 15,
    ));
    _state.searchTags.forEach((element) {
      tags.add(GestureDetector(
          onTap: () {
            print(element);
            setState(() {
              _state.searchInputText = element;
              _dispatch(HomeActionCreator.querySearchResult(element));
            });
          },
          child: BubbleItem(
              text: element,
              itemData: element == _state.searchInputText
                  ? BubbleItems.MobileActive
                  : BubbleItems.MobileGary)));
    });
    return tags;
  }
}
