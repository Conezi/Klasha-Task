
import 'package:equatable/equatable.dart';

import '../../models/data_models/ingredient.dart';
import '../../models/data_models/recipe.dart';

abstract class RecipesStates extends Equatable{
  const RecipesStates();
}

class InitialState extends RecipesStates {
  const InitialState();

  @override
  List<Object?> get props => [];

}

class Loading extends RecipesStates {
  const Loading();

  @override
  List<Object?> get props => [];
}

class IngredientsLoaded extends RecipesStates {
  final List<Ingredient> ingredient;
  const IngredientsLoaded(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class RecipesLoaded extends RecipesStates {
  final List<Recipe> recipes;
  const RecipesLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class RecipesNetworkErr extends RecipesStates {
  final String? message;
  const RecipesNetworkErr(this.message);

  @override
  List<Object?> get props => [message];
}
