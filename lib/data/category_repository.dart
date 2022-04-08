import 'dart:async';

import 'package:smart_expenses/data/model/response_info.dart';

import 'api_provider.dart';

class CategoryRepository {
  final ApiProvider _provider = ApiProvider();

  Future<ResponseInfo> fetchCategories(Map data) async {
    final response =
        await _provider.post("api/v1.0/master/CategoryStatistics", data);
    return ResponseInfo.fromJson(response);
  }

  Future<ResponseInfo> fetchSubCategories(Map data) async {
    final response =
        await _provider.post("api/v1.0/master/SubCategoryStatistics", data);
    return ResponseInfo.fromJson(response);
  }
}
