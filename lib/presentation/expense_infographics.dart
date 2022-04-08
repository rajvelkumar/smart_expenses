import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_expenses/data/model/response.dart';
import 'package:smart_expenses/domain/bloc/expense_bloc.dart';
import 'package:smart_expenses/domain/model/expense.dart';
import 'package:smart_expenses/domain/model/expense_updated_data.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart();

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  late ExpenseBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ExpenseBloc();
    _bloc.fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Response<ExpenseUpdatedData>>(
        stream: _bloc.chuckDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                //return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return ExpenseView(
                  timeline: snapshot.data!.data.expenseData,
                  sum: snapshot.data!.data.sum,
                );
              case Status.ERROR:
                break;
            }
          }
          return Container();
        },
      ),
    );
  }
}

class ExpenseView extends StatefulWidget {
  const ExpenseView({
    Key? key,
    required this.timeline,
    required this.sum,
  }) : super(key: key);

  final List<charts.Series<ExpenseData, String>> timeline;
  final double sum;

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {

  static final Map<String, String> chartTypeMap = {
    'pie': 'pie',
    'bar': 'bar',
    'donut': 'donut',
  };

  String _selectedChartType = chartTypeMap.keys.first;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: charts.PieChart<String>(
                  widget.timeline,
                  behaviors: [
                    // our title behaviour
                    charts.DatumLegend(
                      position: charts.BehaviorPosition.end,
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                      showMeasures: true,
                      desiredMaxColumns: 1,
                      desiredMaxRows: 4,
                      legendDefaultMeasure: charts.LegendDefaultMeasure.average,
                      measureFormatter: (num? value) {
                        return value == null
                            ? '-'
                            : ' ${((value * 100) / widget.sum).toStringAsFixed(1)}%';
                      },
                      entryTextStyle: const charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontFamily: 'Roboto',
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              CupertinoRadioChoice(
                  choices: chartTypeMap,
                  onChange: onGenderSelected,
                  initialKeyValue: _selectedChartType),
              SizedBox(height: 10,)
            ],
          )
          ),
    );
  }
  void onGenderSelected(String chartTypeKey) {
    setState(() {
      _selectedChartType = chartTypeKey;
    });
  }
}
