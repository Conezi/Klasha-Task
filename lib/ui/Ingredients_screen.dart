import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

import '../../di/injection.dart';
import '../bloc/recipes/recipes.dart';
import '../models/view_models/recipes_view_model.dart';
import '../utils/date_time_util.dart';
import 'widget/custom_date_picker.dart';
import 'widget/loading_page.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {

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
          centerTitle: true,
          actions: [
            CustomDatePicker(
                initialDate: _selectedDate,
                onSelected: onDateSelected)
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).shadowColor
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 8),
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
                builder: (context, state) => ViewModelBuilder<RecipesViewModel>.reactive(
                    viewModelBuilder: () => _recipesCubit.viewModel,
                    disposeViewModel: false,
                    builder: (widget, viewModel, child){
                      if(state is Loading && viewModel.ingredients.isEmpty){
                        return const LoadingPage(length: 10);
                      }
                      if(viewModel.ingredients.isEmpty){
                        return Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'No Ingredients available for ${DateTimeUtil.dateFormat.format(_selectedDate)}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).textTheme.bodyText1!.color),
                                  children: [
                                    TextSpan(
                                        text: '\ntry 25 Nov, 2020, 06 Nov, 2019',
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 2,
                                            color: Theme.of(context).textTheme.caption!.color)
                                    )
                                  ]
                                ),
                                textAlign: TextAlign.center),
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            itemCount: viewModel.ingredients.length,
                            separatorBuilder: (context, int index)=> const Divider(),
                            itemBuilder: (context, int index)
                            => ListTile(
                              leading: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                      color: Theme.of(context).shadowColor.withOpacity(0.1))),
                              title: Text(viewModel.ingredients[index].title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              subtitle: Text(DateTimeUtil.dateFormat.format(
                                  viewModel.ingredients[index].useBy),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                            )),
                      );
                    }
                )),
          ],
        )
    );
  }

  void onDateSelected(DateTime date) {
    setState(()=> _selectedDate = date);
    _recipesCubit.viewModel.setFilterIngredient(date);
  }

}
