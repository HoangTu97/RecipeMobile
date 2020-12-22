import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/repository/recipe.dart';

import 'event.dart';
import 'state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository recipeRepository;

  RecipeBloc({@required this.recipeRepository}) : super(RecipeInitial());

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    final currentState = state;
    if (event is RecipeReload) {
      try {
        yield RecipeInitial();
        final recipes = await recipeRepository.fetch(event.text, 0, 20);
        yield RecipeSuccess(recipes: recipes, hasReachedMax: false);
        return;
      } catch (_) {
        yield RecipeFailure();
      }
    }
    if (event is RecipeFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is RecipeInitial) {
          final recipes = await recipeRepository.fetch(event.text, 0, 20);
          yield RecipeSuccess(recipes: recipes, hasReachedMax: false);
          return;
        }
        if (currentState is RecipeSuccess) {
          final recipes = await recipeRepository.fetch(
              event.text, (currentState.recipes.length / 20).round(), 20);
          yield recipes.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : RecipeSuccess(
                  recipes: currentState.recipes + recipes,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield RecipeFailure();
      }
    }
  }

  bool _hasReachedMax(RecipeState state) =>
      state is RecipeSuccess && state.hasReachedMax;
}
