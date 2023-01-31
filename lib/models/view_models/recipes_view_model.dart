import '../../res/enum.dart';
import '../data_models/ingredient.dart';
import '../data_models/recipe.dart';
import 'base_viewmodel.dart';

class RecipesViewModel extends BaseViewModel {
  List<Ingredient> _ingredients = [];
  List<Ingredient> _filteredIngredients = [];

  List<Recipe> _recipes = [];

  Future<void> setIngredient(List<Ingredient> ingredients) async {
    _ingredients = ingredients;
    setFilterIngredient(DateTime.now());
  }

  Future<void> setFilterIngredient(DateTime date) async {
    _filteredIngredients = _ingredients
        .where((i) =>
            i.useBy.day == date.day &&
            i.useBy.month == date.month &&
            i.useBy.year == date.year)
        .toList();
    setViewState(ViewState.success);
  }

  Future<void> setRecipes(List<Recipe> recipes) async {
    _recipes = recipes;
    setViewState(ViewState.success);
  }

  List<Ingredient> get ingredients => _filteredIngredients;

  List<Recipe> get recipes => _recipes;
}
