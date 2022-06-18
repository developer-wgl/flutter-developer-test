import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_developer_test/model/search_module.dart';
import 'action.dart';
import 'state.dart';

Reducer<HomeState>? buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.dataChanged: _updatePageData,
      HomeAction.stateChanged: _updatePageContentState,
    },
  );
}

/// data build
HomeState _updatePageData(HomeState state, Action action) {
  state..data = action.payload as List<SearchResponseModule>?;
  return state.clone();
}

/// contentState change
HomeState _updatePageContentState(HomeState state, Action action) {
  state..contentState = action.payload;
  return state.clone();
}
