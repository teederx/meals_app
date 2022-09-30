import 'package:flutter/material.dart';

import '../items/meals_item.dart';
import '../models/meals.dart';

class CategoryMealsPage extends StatefulWidget {
  static const routeName = '/category_meals';
  const CategoryMealsPage({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  final List<Meals> availableMeals;

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  String? categoryTitle;
  Color? categoryColor;
  List<Meals>? displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    //Use condition statement because 'didChangeDependencies' after every change in state...
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
      final String categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      categoryColor = routeArgs['color'];
      displayedMeals = widget.availableMeals
          .where((meals) => meals.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
        backgroundColor: categoryColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealsItem(
            title: displayedMeals![index].title,
            imageURL: displayedMeals![index].imageURL,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            id: displayedMeals![index].id,
            color: categoryColor!,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
