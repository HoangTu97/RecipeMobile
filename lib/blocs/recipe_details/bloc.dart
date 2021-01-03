import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/repository/index.dart';
import 'package:recipes/repository/recipe.dart';

import 'event.dart';
import 'state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final RecipeRepository recipeRepository;

  RecipeDetailBloc({@required this.recipeRepository})
      : super(RecipeDetailInitial());

  @override
  Stream<RecipeDetailState> mapEventToState(RecipeDetailEvent event) async* {
    if (event is RecipeDetailFetched) {
      // try {
      if (state is RecipeDetailInitial) {
        final recipe = await recipeRepository.detail(event.id);
        yield RecipeDetailSuccess(detail: recipe);
        return;
      }
      if (state is RecipeDetailSuccess) {
        final recipe = await recipeRepository.detail(event.id);
        yield RecipeDetailSuccess(detail: recipe);
      }
      // } catch (_) {
      //   yield RecipeDetailFailure();
      // }
    }
  }
}
