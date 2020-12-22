import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/auth/bloc.dart';
import 'package:recipes/repository/index.dart';
import 'package:recipes/services/locator.dart';

import 'app.dart';

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(),
        ),
      ],
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: MyApp(),
      ),
    );
  }
}
