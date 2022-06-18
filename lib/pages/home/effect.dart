import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_developer_test/model/search_module.dart';
import 'package:flutter_developer_test/utils/services.dart';
import 'action.dart';
import 'state.dart';

Effect<HomeState>? buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _initState,
    HomeAction.requestSearchData: _queryHomeInfo,
  });
}

/// run on app init.
void _initState(Action action, Context<HomeState> ctx) {
  Future.delayed(Duration(milliseconds: 100)).then((info) {
    _queryHomeInfo(
        Action(action.type, payload: ctx.state.searchInputText), ctx);
  });
}

/// request data
void _queryHomeInfo(Action action, Context<HomeState> ctx) {
  _onFetchHomeInfoStart(ctx.dispatch, ctx.state);
  HomeService.querySearchDetail(action.payload).then((response) {
    _onFetchHomeInfoSuccess(response, ctx.dispatch, ctx.state);
  }).catchError((error) {
    _onFetchHomeInfoError(ctx.dispatch, ctx.state);
  });
}

/// start loading action
void _onFetchHomeInfoStart(Dispatch dispatch, HomeState state) {
  dispatch(HomeActionCreator.updatePageContentState(PageContentState.Loading));
}

/// update state and end loading actions.
void _onFetchHomeInfoSuccess(
    List<SearchResponseModule> models, Dispatch dispatch, HomeState state) {
  dispatch(HomeActionCreator.updatePageDate(models));
  dispatch(HomeActionCreator.updatePageContentState(PageContentState.List));
}

/// error state action
void _onFetchHomeInfoError(Dispatch dispatch, HomeState state) {
  dispatch(HomeActionCreator.updatePageContentState(PageContentState.Error));
}
