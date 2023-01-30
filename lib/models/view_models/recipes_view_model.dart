import '../../res/enum.dart';
import 'base_viewmodel.dart';

class RecipesViewModel extends BaseViewModel {

  List _recipes = [];

  Future<void> setRecipes(List recipes) async {
    _recipes = recipes;
    setViewState(ViewState.success);
  }


  List get recipes => _recipes;

}
