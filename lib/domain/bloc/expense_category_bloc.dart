import 'dart:async';

import 'package:smart_expenses/data/category_repository.dart';
import 'package:smart_expenses/data/model/response.dart';
import 'package:smart_expenses/data/model/response_info.dart';

class ExpenseCategoryBloc {
  late final CategoryRepository _expenseCategoryRepository = CategoryRepository();
  final _expenseCategoryDataController =
      StreamController<Response<ResponseInfo>>();

  StreamSink<Response<ResponseInfo>> get categoryDataSink =>
      _expenseCategoryDataController.sink;

  Stream<Response<ResponseInfo>> get categoryDataStream =>
      _expenseCategoryDataController.stream;

  expenseCategoryBloc() {
    fetchCategoryExpenses();
  }

  fetchCategoryExpenses() async {
    Map data = {'FromDate': '2021-06-09', 'ToDate': '2022-06-10'};
    categoryDataSink.add(Response.loading('Getting Categories'));
    try {
      ResponseInfo responseData =
          await _expenseCategoryRepository.fetchCategories(data);
      categoryDataSink.add(Response.completed(responseData));
    } catch (e) {
      categoryDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }
  fetchSubCategories(int categoryId) async {
    Map data = {'FromDate': '2021-06-09', 'ToDate': '2022-06-10','CategoryId':categoryId};
    categoryDataSink.add(Response.loading('Getting Sub Categories'));
    try {
      ResponseInfo responseData =
      await _expenseCategoryRepository.fetchSubCategories(data);
      categoryDataSink.add(Response.completed(responseData));
    } catch (e) {
      categoryDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _expenseCategoryDataController.close();
  }
}
