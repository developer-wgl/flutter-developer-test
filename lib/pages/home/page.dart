import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/foundation.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view_mobile.dart';
import 'view_web.dart';

/// home page
class HomePage extends Page<HomeState, Map> {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: kIsWeb ? buildWebView : buildMobileView, /// web or mobile
          dependencies: Dependencies<HomeState>(
              adapter: null, slots: <String, Dependent<HomeState>>{}),
          middleware: <Middleware<HomeState>>[],
        );
}
