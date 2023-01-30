import '../../res/enum.dart';
import '../data_models/ingredient.dart';
import '../data_models/recipe.dart';
import 'base_viewmodel.dart';

class RecipesViewModel extends BaseViewModel {

  List<Ingredient> _ingredient = [];
  List<Recipe> _recipes = [];

  Future<void> setIngredient(List<Ingredient> ingredient) async {
    _ingredient = ingredient;
    setViewState(ViewState.success);
  }

  Future<void> setRecipes(List<Recipe> recipes) async {
    _recipes = recipes;
    setViewState(ViewState.success);
  }

  List<Ingredient> get ingredient => _ingredient;

  List<Recipe> get recipes => _recipes;

}
