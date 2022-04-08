import 'dart:async';

import 'package:smart_expenses/data/model/response_info.dart';

import 'api_provider.dart';

class ExpenseRepository {
  final ApiProvider _provider = ApiProvider();

  Future<ResponseInfo> fetchExpenses() async {
    final response = await _provider.get("api/v1.0/master/ExpenseList");
    return ResponseInfo.fromJson(response);
  }
}
