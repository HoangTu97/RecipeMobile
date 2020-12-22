import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/recipe_details/bloc.dart';
import 'package:recipes/pages/home.dart';
import 'package:recipes/pages/login.dart';
import 'package:recipes/pages/recipe_detail.dart';
import 'package:recipes/repository/recipe.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/recipe':
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider<RecipeRepository>(
            create: (_) => FakeRecipeRepositoryImpl(),
            child: BlocProvider<RecipeDetailBloc>(
              create: (context) => RecipeDetailBloc(
                recipeRepository:
                    RepositoryProvider.of<RecipeRepository>(context),
              ),
              child: RecipeDetailPage(id: args['id']),
            ),
          ),
        );
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        break;
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
