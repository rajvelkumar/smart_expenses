import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expenses/data/model/response_data.dart';
import 'package:smart_expenses/domain/bloc/category_bloc.dart';
import 'package:smart_expenses/domain/bloc/expense_category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen();

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late ExpenseCategoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ExpenseCategoryBloc();
    _bloc.fetchCategoryExpenses();
  }

  /*@override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Response<ResponseInfo>>(
        stream: _bloc.categoryDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
              //return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return CategoryView(
                  categories: snapshot.data!.data.responseData!,
                  subCategoryBloc: _bloc,
                );
              case Status.ERROR:
                break;
            }
          }
          return Container();
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<CategoryCubit, List<ResponseData>>(
      builder: (context, categories) {
        return CategoryView(
          categories: categories,
          subCategoryBloc: _bloc,
        );
      return Container();
      },
    ));
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.categories,
    required this.subCategoryBloc,
  }) : super(key: key);

  final List<ResponseData> categories;
  final ExpenseCategoryBloc subCategoryBloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Top Spending Categories",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ),
                        itemCount: categories.length,
                        itemBuilder: _listItemBuilder,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "view all categories",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              color: Colors.black26),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))));
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    ResponseData responseData = categories[index];

    return GestureDetector(
      onTap: () {
        //subCategoryBloc.fetchSubCategories(responseData.categoryId!)
      },
      child: Container(
          padding: const EdgeInsets.all(6.0),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*  CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(''),
              ),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    responseData.categoryName!.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    " \$ ${responseData.amountSpent.toString().trim()} spent",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_right_outlined),
              )
            ],
          )),
    );
  }
}
