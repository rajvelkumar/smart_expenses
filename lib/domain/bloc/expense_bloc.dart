import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smart_expenses/data/expense_repoistory.dart';
import 'package:smart_expenses/data/model/response.dart';
import 'package:smart_expenses/data/model/response_data.dart';
import 'package:smart_expenses/data/model/response_info.dart';
import 'package:smart_expenses/domain/model/expense.dart';
import 'package:smart_expenses/domain/model/expense_updated_data.dart';

class ExpenseBloc {
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final _expenseDataController =
      StreamController<Response<ExpenseUpdatedData>>();

  StreamSink<Response<ExpenseUpdatedData>>
      get chuckDataSink => _expenseDataController.sink;

  Stream<Response<ExpenseUpdatedData>>
      get chuckDataStream => _expenseDataController.stream;

  expenseBloc() {
    fetchExpenses();
  }

  fetchExpenses() async {
    chuckDataSink.add(Response.loading('Getting Expense'));
    try {
      ResponseInfo responseData = await _expenseRepository.fetchExpenses();

      var expenseFinalData = combineAmountSpentData(responseData.responseData)
          .entries
          .map((e) => ExpenseData(e.key, e.value))
          .toList();
      double sum = expenseFinalData
          .map((expense) => expense.amount)
          .fold(0, (prev, amount) => prev + amount);

      chuckDataSink.add(Response.completed(ExpenseUpdatedData(getChartData(expenseFinalData),sum)));
    } catch (e) {
      chuckDataSink.add(Response.error(e.toString()));
    }
  }

  List<charts.Series<ExpenseData, String>>  getChartData(List<ExpenseData> expenseFinalData){
    final blue = charts.MaterialPalette.blue.shadeDefault;
    final red = charts.MaterialPalette.red.shadeDefault;
    final green = charts.MaterialPalette.green.shadeDefault;
    final yellow = charts.MaterialPalette.yellow.shadeDefault;
    List<charts.Series<ExpenseData, String>> timeline = [
      charts.Series(
        id: "Expenses",
        data: expenseFinalData,
        domainFn: (ExpenseData expenseInfo, _) => expenseInfo.category,
        measureFn: (ExpenseData expenseInfo, _) => expenseInfo.amount,
        colorFn: (_, index) {
          switch (index) {
            case 0:
              {
                return red;
              }
            case 1:
              {
                return green;
              }
            case 2:
              {
                return yellow;
              }
            case 3:
              {
                return blue;
              }
            default:
              return blue;
          }
        },
      )
    ];
    return timeline;
}

  Map<dynamic, dynamic> combineAmountSpentData(
      List<ResponseData>? responseData) {
    var sumMap = {};
    for (var product in responseData!) {
      if (sumMap.containsKey(product.subCategoryName)) {
        sumMap[product.subCategoryName!] += product.amountSpent!;
      } else {
        sumMap[product.subCategoryName!] = product.amountSpent!;
      }
    }
    return sumMap;
  }

  dispose() {
    _expenseDataController.close();
  }
}
