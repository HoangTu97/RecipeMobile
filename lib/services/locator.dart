import 'package:get_it/get_it.dart';
import 'package:recipes/services/navigation.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
}
