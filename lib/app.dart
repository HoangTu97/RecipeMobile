import 'package:flutter/material.dart';
import 'package:recipes/routes.dart';
import 'package:recipes/services/locator.dart';
import 'package:recipes/services/navigation.dart';
import 'package:recipes/style/theme.dart' as Theme;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Theme.Colors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
