import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_developer_test/constant.dart';
import 'package:flutter_developer_test/model/search_module.dart';

/// Home Page state
class HomeState implements Cloneable<HomeState> {
  List<SearchResponseModule>? data; // response data
  String searchInputText; // edit input text
  String searchInputHintText; // edit input hint text
  var searchTags = []; // edit input hint text

  /// page content area state. see [PageContentState]
  PageContentState? contentState;

  HomeState({
    this.data,
    required this.searchInputText,
    required this.searchInputHintText,
    required this.searchTags,
    this.contentState,
  });

  @override
  HomeState clone() {
    return HomeState(
        searchTags: this.searchTags,
        searchInputHintText: this.searchInputHintText,
        searchInputText: this.searchInputText)
      ..data = this.data
      ..contentState = this.contentState;
  }
}

HomeState initState(Map? args) {
  return HomeState(
    searchTags: Constants.SearchTags,
    searchInputHintText: 'Search',
    searchInputText: 'Languages',
  )
    ..data = null
    ..contentState = PageContentState.Loading;
}

/// page content area state.
enum PageContentState { Error, NotFound, List, Loading }
