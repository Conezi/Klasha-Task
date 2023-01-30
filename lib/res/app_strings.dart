
class AppStrings {
  static const String appName = 'Klasha Recipes';

  static const String networkErrorMessage = "Network error, try again later";

  /// Base
  static const String baseUrl = 'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';

  static String fetchRecipesUrl(List<String> ingredients)
  => '$baseUrl/recipes?ingredients=${ingredients.join(',')}';


}
