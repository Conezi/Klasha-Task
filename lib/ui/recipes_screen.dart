import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:tech_task/res/app_colors.dart';

import '../bloc/recipes/recipes.dart';
import '../di/injection.dart';
import '../models/data_models/ingredient.dart';
import '../models/view_models/recipes_view_model.dart';
import 'widget/loading_page.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {

  final _recipesCubit = injector.get<RecipesCubit>();

  @override
  void didChangeDependencies() {
    _recipesCubit.fetchRecipes(
        ModalRoute.of(context)?.settings.arguments as List<Ingredient>);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recipes'),
          iconTheme: ThemeData.light().iconTheme.copyWith(
          color: AppColors.lightBackground
        )),
        body: BlocBuilder<RecipesCubit, RecipesStates>(
            bloc: _recipesCubit,
            builder: (context, state) => ViewModelBuilder<RecipesViewModel>.reactive(
                viewModelBuilder: () => _recipesCubit.viewModel,
                disposeViewModel: false,
                builder: (widget, viewModel, child){
                  if(state is Loading){
                    return const LoadingPage(length: 10);
                  }
                  if(viewModel.recipes.isEmpty){
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                            'No Recipe Found',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).textTheme.bodyText1!.color)),
                      ),
                    );
                  }
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      itemCount: viewModel.recipes.length,
                      separatorBuilder: (context, int index)=> const Divider(),
                      itemBuilder: (context, int index){
                        final recipe = viewModel.recipes[index];
                        return ListTile(
                          leading: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  color: Theme.of(context).shadowColor.withOpacity(0.1))),
                          title: Text(recipe.title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          subtitle: Text(recipe.ingredients.join(', '),
                              style: TextStyle(
                                  fontSize: 14)),
                        );
                      });
                }
            ))
    );
  }

}
