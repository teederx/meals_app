import 'package:flutter/material.dart';

import '../items/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      padding: const EdgeInsets.all(20),
      children: dummyCategories
          .map(
            (data) => CategoryItem(
              id: data.id,
              title: data.title,
              color: data.color,
            ),
          )
          .toList(),
    );
  }
}
