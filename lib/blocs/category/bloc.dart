import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/repository/category.dart';

import 'event.dart';
import 'state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({@required this.categoryRepository}) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryFetched) {
      try {
        final categories = await categoryRepository.fetch();
        yield CategorySuccess(categories: categories);
        return;
      } catch (_) {
        yield CategoryFailure();
      }
    }
  }
}
