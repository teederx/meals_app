import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../items/meals_item.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key, required this.favoriteMeals})
      : super(key: key);

  final List<Meals> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('Add your favorites here!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealsItem(
            title: favoriteMeals[index].title,
            imageURL: favoriteMeals[index].imageURL,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
            id: favoriteMeals[index].id,
            color: Theme.of(context).primaryColor,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
