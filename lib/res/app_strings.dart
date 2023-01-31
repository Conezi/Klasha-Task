import '../models/data_models/ingredient.dart';

class AppStrings {
  static const String appName = 'Klasha Recipes';

  static const String networkErrorMessage = "Network error, try again later";

  /// Base
  static const String baseUrl =
      'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';

  static const String fetchIngredientsUrl = '$baseUrl/ingredients';
  static String fetchRecipesUrl(List<Ingredient> ingredients) =>
      '$baseUrl/recipes?ingredients=${ingredients.fold([], (previousValue, i) => previousValue..add(i.title)).join(',')}';
}
