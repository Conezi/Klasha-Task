import 'package:tech_task/models/data_models/ingredient.dart';
import 'package:tech_task/models/data_models/recipe.dart';

import '../../../res/app_strings.dart';
import '../../utils/http_helper.dart';
import 'recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final HttpHelper httpHelper;
  const RecipesRepositoryImpl(this.httpHelper);

  @override
  Future<List<Ingredient>> fetchIngredient() async {
    final map = await httpHelper.get(AppStrings.fetchIngredientsUrl);
    return List<Ingredient>.from(map.map((x) => Ingredient.fromMap(x)));
  }

  @override
  Future<List<Recipe>> fetchRecipes(List<Ingredient> ingredients) async {
    final map = await httpHelper.get(AppStrings.fetchRecipesUrl(ingredients));
    return List<Recipe>.from(map.map((x) => Recipe.fromMap(x)));
  }
}
