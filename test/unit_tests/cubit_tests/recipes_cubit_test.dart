import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/bloc/recipes/recipes.dart';
import 'package:tech_task/models/data_models/ingredient.dart';
import 'package:tech_task/models/data_models/recipe.dart';
import 'package:tech_task/requests/utils/exceptions.dart';

import '../data_factory/recipes_data_factory.dart';
import '../mocks/repository_mocks/mock_recipes_repository.dart';
import '../mocks/view_model_mocks/mock_user_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRecipesRepository recipesRepository;
  late MockRecipesViewModel recipesViewModel;
  late RecipesCubit recipesCubit;

  final ingredients = List<Ingredient>.from(
      RecipesDataFactory.ingredients.map((x) => Ingredient.fromMap(x)));
  final recipes = List<Recipe>.from(RecipesDataFactory.recipes.map((x) => Recipe.fromMap(x)));

  setUp(() {
    recipesRepository = MockRecipesRepository();
    recipesViewModel = MockRecipesViewModel();
    recipesCubit = RecipesCubit(
        repository: recipesRepository,
        viewModel: recipesViewModel);
  });

  tearDown(() {
    recipesCubit.close();
    recipesViewModel.dispose();
  });

  group('Test fetch ingredients in recipes cubit ', () {
    blocTest(
        'emits [Loading(), IngredientsLoaded()]'
        ' when request was successful and has a valid data',
        build: () {
          when(() => recipesRepository.fetchIngredient()).thenAnswer(
            (_) => Future.value(ingredients),
          );
          when(() => recipesViewModel.setIngredient(ingredients)).thenAnswer(
            (_) => Future.value(ingredients),
          );
          return recipesCubit;
        },
        act: (RecipesCubit cubit) => cubit.fetchIngredient(),
        expect: () => [Loading(), IngredientsLoaded(ingredients)]);

    blocTest(
        'emits [Loading(), RecipesNetworkErr()]'
            ' when error occurred while fetching ingredients',
        build: () {
          when(() => recipesRepository.fetchIngredient()).thenThrow(
              NetworkException('An error occurred'));
          return recipesCubit;
        },
        act: (RecipesCubit cubit) => cubit.fetchIngredient(),
        expect: () => [
          Loading(),
          const RecipesNetworkErr('An error occurred')
        ]);
  });

  group('Test fetch recipes in recipes cubit ', () {
    blocTest(
        'emits [Loading(), RecipesLoaded()]'
            ' when request was successful and has a valid data',
        build: () {
          when(() => recipesRepository.fetchRecipes([])).thenAnswer(
                (_) => Future.value(recipes),
          );
          when(() => recipesViewModel.setRecipes(recipes)).thenAnswer(
                (_) => Future.value(recipes),
          );
          return recipesCubit;
        },
        act: (RecipesCubit cubit) => cubit.fetchRecipes([]),
        expect: () => [Loading(), RecipesLoaded(recipes)]);

    blocTest(
        'emits [Loading(), RecipesNetworkErr()]'
            ' when error occurred while fetching recipes',
        build: () {
          when(() => recipesRepository.fetchRecipes([])).thenThrow(
              NetworkException('An error occurred'));
          return recipesCubit;
        },
        act: (RecipesCubit cubit) => cubit.fetchRecipes([]),
        expect: () => [
          Loading(),
          const RecipesNetworkErr('An error occurred')
        ]);
  });

}
