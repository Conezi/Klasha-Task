import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/data_models/ingredient.dart';
import '../../models/view_models/recipes_view_model.dart';
import '../../requests/repositories/recipes_repository/recipes_repository.dart';
import '../../requests/utils/exceptions.dart';
import 'recipies_states.dart';

class RecipesCubit extends Cubit<RecipesStates> {
  RecipesCubit({required this.repository, required this.viewModel})
      : super(const InitialState());

  final RecipesRepository repository;
  final RecipesViewModel viewModel;

  Future<void> fetchIngredient() async {
    try {
      emit(Loading());

      final response = await repository.fetchIngredient();

      viewModel.setIngredient(response);
      emit(IngredientsLoaded(response));
    } on ApiException catch (e) {
      emit(RecipesNetworkErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(RecipesNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> fetchRecipes(List<Ingredient> ingredients) async {
    try {
      emit(Loading());

      final response = await repository.fetchRecipes(ingredients);

      viewModel.setRecipes(response);
      emit(RecipesLoaded(response));
    } on ApiException catch (e) {
      emit(RecipesNetworkErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(RecipesNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
