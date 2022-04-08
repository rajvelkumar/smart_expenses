import 'expense.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class ExpenseUpdatedData {
  List<charts.Series<ExpenseData, String>> expenseData;
  final double sum;

   ExpenseUpdatedData(this.expenseData, this.sum);
}