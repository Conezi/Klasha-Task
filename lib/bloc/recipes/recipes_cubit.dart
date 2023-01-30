import 'package:flutter_bloc/flutter_bloc.dart';

import 'recipies_states.dart';

class RecipesCubit extends Cubit<RecipesStates> {
  RecipesCubit() : super(const InitialState());



}
