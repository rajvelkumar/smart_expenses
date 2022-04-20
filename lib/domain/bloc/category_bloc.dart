import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expenses/data/category_repository.dart';
import 'package:smart_expenses/data/model/response_data.dart';

class CategoryCubit extends Cubit<List<ResponseData>> {
  var categoryRepository = CategoryRepository();

  Map data = {'FromDate': '2021-06-09', 'ToDate': '2022-06-10'};

  CategoryCubit( ) : super([]);

  void getCategories() async =>
      emit(await categoryRepository.fetchCategories(data));
}
