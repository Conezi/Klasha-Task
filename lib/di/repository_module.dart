import 'package:get_it/get_it.dart';

import '../requests/repositories/recipes_repository/recipes_repository.dart';
import '../requests/repositories/recipes_repository/recipes_repository_impl.dart';


/// A DI module for injecting repositories

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton<RecipesRepository>(
      () => RecipesRepositoryImpl());
}

 
