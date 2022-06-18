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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

Widget buildWebView(
    HomeState state, Dispatch dispatch, ViewService viewService) {
  return MyHomeWidget(
    state: state,
    dispatch: dispatch,
    viewService: viewService,
  );
}

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
      backgroundColor: Color(0xffd6e9ff),
      body: Center(
        child: Container(
          height: 620,
          width: 690,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(10, 12),
                blurRadius: 20,
                spreadRadius: 5,
                color: Color(0x32325D40),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
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
                  margin:
                      EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 24),
                  child: SearchInput(
                    hintText: _state.searchInputHintText,
                    inputData: getSearchBoxStyle(),
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
                height: 32,
                margin: EdgeInsets.only(bottom: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: buildBubbleTagsList(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 24, right: 24),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      )),
                  child: buildPageContent(),
                ),
              ),
              Divider(
                height: 1,
                color: MyColor.Gray,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 30,
                margin: EdgeInsets.only(left: 24),
                child: Text(
                  getTipsText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isError() ? MyColor.Error : MyColor.Paragraph,
                      fontFamily: MyFont.Poppins),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// bottom tips state
  String getTipsText() {
    if (isError()) {
      return "Something wrong happened but this is not your fault : )";
    }
    if (isLoading()) {
      return "Searching";
    }
    if (isNotFound()) {
      return "No result";
    }
    return "${_state.data?.length} results";
  }

  /// search input view state
  SearchInputData getSearchBoxStyle() {
    if (isError()) {
      return SearchInputStyle.WebErrorStyle;
    }
    if (isLoading()) {
      return SearchInputStyle.WebActiveStyle;
    }
    if (isNotFound()) {
      return SearchInputStyle.WebActiveStyle;
    }
    return SearchInputStyle.WebDefaultStyle;
  }

  /// mid content page state
  Widget buildPageContent() {
    if (isLoading()) return LoadingPage();
    if (isError())
      // error img show.
      return Center(
          child: SizedBox(
        width: 240,
        height: 240,
        child: SvgPicture.asset(
          "assets/svg/state_error.svg",
        ),
      ));

    // not found img show.
    if (isNotFound())
      return Center(
          child: SizedBox(
        width: 240,
        height: 240,
        child: SvgPicture.asset(
          "assets/svg/state_not_found.svg",
        ),
      ));

    // real data listview show.
    List<Widget> list = [];
    _state.data?.forEach((element) {
      list.add(Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        child: MaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: LanguageItem(
              image: element.image,
              title: element.title,
              description: element.description,
              url: element.url,
              category: element.category),
          onPressed: () {
            launchUrl(Uri.parse(element.url!),
                mode: LaunchMode.externalApplication);
          },
        ),
      ));
    });

    // push languages items
    // TODO AnimatedList replace ListView ， no more time
    return ListView(
      children: list,
    );
  }

  /// tags bubble list.
  List<Widget> buildBubbleTagsList() {
    List<Widget> tags = [];
    tags.add(SizedBox(
      width: 24,
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
                  ? BubbleItems.WebActive
                  : BubbleItems.WebGary)));
    });
    return tags;
  }

  bool isError() =>
      _state.contentState == PageContentState.Error || _state.data == null;

  bool isNotFound() {
    return _state.contentState == PageContentState.NotFound ||
        _state.data!.length == 0;
  }

  bool isLoading() => _state.contentState == PageContentState.Loading;
}
