import 'package:get_it/get_it.dart';

import '../models/view_models/recipes_view_model.dart';

/// A DI module for injecting view models

Future<void> init(GetIt injector) async {
  injector.registerSingleton<RecipesViewModel>(RecipesViewModel());
}

 
