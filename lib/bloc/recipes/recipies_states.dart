
abstract class RecipesStates{
  const RecipesStates();
}

class InitialState extends RecipesStates {
  const InitialState();

}

class Loading extends RecipesStates {
  @override
  List<Object> get props => [];
}

class RecipesLoaded extends RecipesStates {
  final List recipes;
  const RecipesLoaded(this.recipes);
  @override
  List<Object> get props => [recipes];
}

class RecipesNetworkErr extends RecipesStates {
  final String? message;
  const RecipesNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}
