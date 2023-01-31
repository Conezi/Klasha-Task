import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

import '../../di/injection.dart';
import '../bloc/recipes/recipes.dart';
import '../models/view_models/recipes_view_model.dart';
import '../utils/date_time_util.dart';
import 'widget/loading_page.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {

  final _recipesCubit = injector.get<RecipesCubit>();

  @override
  void didChangeDependencies() {
    _recipesCubit.fetchIngredient();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ingredient'),
          centerTitle: true,
        ),
        body: BlocBuilder<RecipesCubit, RecipesStates>(
            bloc: _recipesCubit,
            builder: (context, state) => ViewModelBuilder<RecipesViewModel>.reactive(
                viewModelBuilder: () => _recipesCubit.viewModel,
                disposeViewModel: false,
                builder: (widget, viewModel, child){
                  if(state is Loading && viewModel.ingredient.isEmpty){
                    return const LoadingPage(length: 10);
                  }
                  if(viewModel.ingredient.isEmpty){
                    return const Text(
                      'No Ingredients available for selected date'
                    );
                  }
                  return Column(
                      children: [
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              itemCount: viewModel.ingredient.length,
                              separatorBuilder: (context, int index)=> const Divider(),
                              itemBuilder: (context, int index)
                              => ListTile(
                                leading: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                        color: Theme.of(context).shadowColor.withOpacity(0.1))),
                                title: Text(viewModel.ingredient[index].title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                subtitle: Text(DateTimeUtil.dateFormat.format(
                                    viewModel.ingredient[index].useBy),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              )),
                        )
                      ]
                  );
                }
            ))
    );
  }

  void onFilterSelected(DateTime date) {

  }

}
