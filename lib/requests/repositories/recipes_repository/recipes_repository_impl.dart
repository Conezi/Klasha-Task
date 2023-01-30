import '../../../res/app_strings.dart';
import '../../utils/requests.dart';
import 'recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository{

  @override
  Future<List> fetchRecipes() async{
    final map=await Requests.instance.get(AppStrings.fetchRecipesUrl([]));
    return List.from(map["data"].map((x) => x));
  }

}