
import '../../models/data_models/ingredient.dart';
import '../../models/data_models/recipe.dart';

abstract class RecipesStates{
  const RecipesStates();
}

class InitialState extends RecipesStates {
  const InitialState();

}

class Loading extends RecipesStates {
}

class IngredientsLoaded extends RecipesStates {
  final List<Ingredient> ingredient;
  const IngredientsLoaded(this.ingredient);
}

class RecipesLoaded extends RecipesStates {
  final List<Recipe> recipes;
  const RecipesLoaded(this.recipes);
}

class RecipesNetworkErr extends RecipesStates {
  final String? message;
  const RecipesNetworkErr(this.message);
}
