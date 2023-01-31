import '../../../models/data_models/ingredient.dart';
import '../../../models/data_models/recipe.dart';

abstract class RecipesRepository {
  Future<List<Ingredient>> fetchIngredient();
  Future<List<Recipe>> fetchRecipes(List<Ingredient> ingredients);
}
