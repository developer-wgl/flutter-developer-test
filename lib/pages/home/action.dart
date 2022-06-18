import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_developer_test/model/search_module.dart';
import 'package:flutter_developer_test/pages/home/state.dart';

/// Event action.
enum HomeAction {
  /*-------------- effect --------------*/
  /// query search data
  requestSearchData,

  /// change state
  stateChanged,

  /// change data
  dataChanged,
}

class HomeActionCreator {
  static Action querySearchResult(String text) {
    return Action(HomeAction.requestSearchData, payload: text);
  }

  static Action updatePageContentState(PageContentState contentState) {
    return Action(HomeAction.stateChanged, payload: contentState);
  }

  static Action updatePageDate(List<SearchResponseModule> models) {
    return Action(HomeAction.dataChanged, payload: models);
  }
}
