import 'package:flutter/material.dart';

import './data/dummy_data.dart';
import './models/meals.dart';
import './pages/filters_page.dart';
import './pages/meal_details_page.dart';
import './pages/tabs_bar_screen.dart';
import './pages/category_meals_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Store the filters the user set...
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meals> _availableMeals = dummyMeals;

  //Function to receive filter data from the filters screen and set the data to '_filters'...
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      //Use the _filters to control the available meals...
      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  List<Meals> _favoriteMeals = [];

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  //add a toggle function which adds meals to favorite if it is indicated as favorite
  //if meal is already a favorite then the function removes it from favorites...
  void _toggleFavorites(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => mealId == meal.id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        //the first meal with the id is added to the favorite...
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsBarScreen(favorite: _favoriteMeals),
        CategoryMealsPage.routeName: (context) => CategoryMealsPage(
              availableMeals: _availableMeals,
            ),
        MealDetailsPage.routeName: (context) => MealDetailsPage(
              toggleFavorite: _toggleFavorites,
              isFavorite: _isMealFavorite,
            ),
        FiltersPage.routeName: (context) => FiltersPage(
              saveFilters: _setFilters,
              filters: _filters,
            ),
      },
    );
  }
}
