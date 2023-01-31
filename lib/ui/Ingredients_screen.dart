import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

import '../../di/injection.dart';
import '../bloc/recipes/recipes.dart';
import '../models/data_models/ingredient.dart';
import '../models/view_models/recipes_view_model.dart';
import '../res/app_routes.dart';
import '../utils/date_time_util.dart';
import 'widget/custom_date_picker.dart';
import 'widget/loading_page.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  List<Ingredient> _selectedIngredients = [];

  DateTime _selectedDate = DateTime.now();

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
        actions: [
          CustomDatePicker(
              initialDate: _selectedDate, onSelected: onDateSelected)
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).shadowColor),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: Text(
                DateTimeUtil.dateFormat.format(_selectedDate),
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.caption!.color,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BlocBuilder<RecipesCubit, RecipesStates>(
              bloc: _recipesCubit,
              builder: (context, state) =>
                  ViewModelBuilder<RecipesViewModel>.reactive(
                      viewModelBuilder: () => _recipesCubit.viewModel,
                      disposeViewModel: false,
                      builder: (widget, viewModel, child) {
                        if (state is Loading && viewModel.ingredients.isEmpty) {
                          return const LoadingPage();
                        }
                        if (viewModel.ingredients.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text.rich(
                                    TextSpan(
                                        text:
                                            'No Ingredients available for ${DateTimeUtil.dateFormat.format(_selectedDate)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color),
                                        children: [
                                          TextSpan(
                                              text:
                                                  '\ntry 25 Nov, 2020, 06 Nov, 2019',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 2,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .color))
                                        ]),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              itemCount: viewModel.ingredients.length,
                              separatorBuilder: (context, int index) =>
                                  const Divider(),
                              itemBuilder: (context, int index) {
                                final ingredient = viewModel.ingredients[index];
                                return ListTile(
                                  onTap: () {
                                    //Todo: uncomment when api returns current data
                                    /*if(ingredient.useBy.isBefore(DateTime.now())){
                                    ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(
                                        SnackBar(content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.warning, color: AppColors.red),
                                            SizedBox(width: 5),
                                            Text(
                                                'Ingredient is past use by date',
                                                textAlign: TextAlign.center),
                                          ],
                                        ), duration: const Duration(seconds: 2),));
                                    return;
                                  }*/
                                    setState(() {
                                      if (_selectedIngredients
                                          .contains(ingredient)) {
                                        _selectedIngredients.remove(ingredient);
                                      } else {
                                        _selectedIngredients.add(ingredient);
                                      }
                                    });
                                  },
                                  selected:
                                      _selectedIngredients.contains(ingredient),
                                  leading: Container(
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: Theme.of(context)
                                              .shadowColor
                                              .withOpacity(0.1))),
                                  title: Text(ingredient.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  subtitle: Text(
                                      DateTimeUtil.dateFormat
                                          .format(ingredient.useBy),
                                      style: TextStyle(fontSize: 16)),
                                );
                              }),
                        );
                      })),
        ],
      ),
      bottomNavigationBar: Builder(builder: (context) {
        if (_selectedIngredients.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      _selectedIngredients.length,
                      (index) => InkWell(
                            onTap: () => setState(() => _selectedIngredients
                                .remove(_selectedIngredients[index])),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              margin: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${_selectedIngredients[index].title}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.cancel,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          )),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ElevatedButton(
                      child: Text('Get Recipes'),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.recipesScreen,
                            arguments: _selectedIngredients);
                        setState(() => _selectedIngredients.clear());
                      }),
                )
              ],
            ));
      }),
    );
  }

  void onDateSelected(DateTime date) {
    setState(() => _selectedDate = date);
    _recipesCubit.viewModel.setFilterIngredient(date);
  }
}
