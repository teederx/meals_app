import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';

import '../items/main_drawer.dart';
import '../pages/categories_page.dart';
import '../pages/favorites_page.dart';

class TabsBarScreen extends StatefulWidget {
  const TabsBarScreen({super.key, required this.favorite});

  final List<Meals> favorite;
  @override
  State<TabsBarScreen> createState() => _TabsBarScreenState();
}

class _TabsBarScreenState extends State<TabsBarScreen> {
  int _selectedPageIndex = 0;

  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'pages': const CategoriesPage(),
        'title': 'Category',
      },
      {
        'pages': FavoritesPage(favoriteMeals: widget.favorite),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _onTap(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['pages'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.category_outlined,
            ),
            activeIcon: const Icon(
              Icons.category_rounded,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.favorite_outline_rounded,
            ),
            activeIcon: const Icon(
              Icons.favorite_rounded,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
