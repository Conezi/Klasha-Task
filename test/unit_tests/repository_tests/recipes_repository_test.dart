import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/models/data_models/ingredient.dart';
import 'package:tech_task/models/data_models/recipe.dart';
import 'package:tech_task/requests/repositories/recipes_repository/recipes_repository.dart';
import 'package:tech_task/requests/repositories/recipes_repository/recipes_repository_impl.dart';
import 'package:tech_task/requests/utils/exceptions.dart';
import 'package:tech_task/res/app_strings.dart';

import '../data_factory/recipes_data_factory.dart';
import '../mocks/mock_http_helper.dart';

void main() {
  late MockHttpHelper mockHttpHelper;
  late RecipesRepository accountRepository;
  final ingredients = RecipesDataFactory.ingredients;
  final recipes = RecipesDataFactory.recipes;

  setUp(() {
    mockHttpHelper = MockHttpHelper();
    accountRepository = RecipesRepositoryImpl(mockHttpHelper);
  });

  tearDown(() {});

  group(
    'Test Fetch ingredients in the recipes repository implementation class ',
    () {
      test(
        'returns a success state of type [List<Ingredient>] if request succeeds',
        () async {
          when(() => mockHttpHelper.get(AppStrings.fetchIngredientsUrl))
              .thenAnswer((_) => Future.value(ingredients));

          expect(
            await accountRepository.fetchIngredient(),
            isA<List<Ingredient>>(),
          );
        },
      );

      test(
        'throws an exception if request fails',
        () async {
          when(() => mockHttpHelper.get(AppStrings.fetchIngredientsUrl))
              .thenThrow(NetworkException('Request failed'));
          expect(() async => await accountRepository.fetchIngredient(),
              throwsException);
        },
      );
    },
  );

  group(
    'Test Fetch recipes in the recipes repository implementation class ',
    () {
      test(
        'returns a success state of type [List<Recipe>] if request succeeds',
        () async {
          when(() => mockHttpHelper.get(AppStrings.fetchRecipesUrl([])))
              .thenAnswer((_) => Future.value(recipes));

          expect(
            await accountRepository.fetchRecipes([]),
            isA<List<Recipe>>(),
          );
        },
      );

      test(
        'throws an exception if request fails',
        () async {
          when(() => mockHttpHelper.get(AppStrings.fetchRecipesUrl([])))
              .thenThrow(NetworkException('Request failed'));
          expect(() async => await accountRepository.fetchRecipes([]),
              throwsException);
        },
      );
    },
  );
}
