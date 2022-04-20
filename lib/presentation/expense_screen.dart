import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expenses/domain/bloc/category_bloc.dart';

import 'category_view.dart';
import 'expense_infographics.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen();

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: SingleChildScrollView(
            child: Column(
          children: [
            const ExpensesChart(),
            BlocProvider<CategoryCubit>(
              create: (context) => CategoryCubit(),
              child: CategoryScreen(),
            )
          ],
        )));
  }
}
