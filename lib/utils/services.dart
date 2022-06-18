import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_developer_test/model/search_module.dart';
import 'package:flutter_developer_test/constant.dart';

/// network services
class HomeService {
  /// request search result
  static Future<List<SearchResponseModule>> querySearchDetail(
      String text) async {
    var response = await Dio()
        .get(Constants.BASE_API + '/?no-throttling=true&search=' + text);
    print("response: " + response.toString());
    // print("response: " + jsonDecode(response.data).toString());

    List<dynamic> responseJson = response.data;
    List<SearchResponseModule> searchList =
        responseJson.map((m) => new SearchResponseModule.fromJson(m)).toList();
    return searchList;
  }
}
