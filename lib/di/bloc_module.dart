import 'package:get_it/get_it.dart';

import '../bloc/recipes/recipes.dart';

/// A DI module for injecting bloc

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton<RecipesCubit>(
          () => RecipesCubit(viewModel: injector.get(),
              repository: injector.get()));
}

 
