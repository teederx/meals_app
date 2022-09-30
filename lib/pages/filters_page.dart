import 'package:flutter/material.dart';
import 'package:meals_app/items/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters-page';
  const FiltersPage({super.key, required this.saveFilters, required this.filters});

  final void Function(Map<String, bool> filterData) saveFilters;
  final Map<String, bool> filters;

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _gluttonFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _gluttonFree = widget.filters['gluten'] as bool;
    _vegetarian = widget.filters['vegetarian'] as bool;
    _vegan = widget.filters['vegan'] as bool;
    _lactoseFree = widget.filters['lactose'] as bool; 
  }

  Widget _buildSwitchList({
    required String imageUrl,
    required String title,
    required String description,
    required bool currentValue,
    required void Function(bool) updateValue,
  }) {
    return SwitchListTile(
      secondary: ImageIcon(
        AssetImage(imageUrl),
        color: Colors.black,
        size: 45,
      ),
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_rounded),
            onPressed: () {
              final selectedFilters = {
                'gluten': _gluttonFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Adjust Your Meal Selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchList(
                  imageUrl: 'assets/images/gluten-free.png',
                  title: 'Gluten-Free',
                  description: 'Only include gluten-free meals',
                  currentValue: _gluttonFree,
                  updateValue: (value) {
                    setState(() {
                      _gluttonFree = value;
                    });
                  },
                ),
                _buildSwitchList(
                  imageUrl: 'assets/images/vegetarian.png',
                  title: 'Vegetarian',
                  description: 'Only include vegetarian meals',
                  currentValue: _vegetarian,
                  updateValue: (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                _buildSwitchList(
                  imageUrl: 'assets/images/vegan.png',
                  title: 'Vegan',
                  description: 'Only include vegan meals',
                  currentValue: _vegan,
                  updateValue: (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
                _buildSwitchList(
                  imageUrl: 'assets/images/no-milk.png',
                  title: 'Lactose-Free',
                  description: 'Only include lactose-free meals',
                  currentValue: _lactoseFree,
                  updateValue: (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
