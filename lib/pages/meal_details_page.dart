import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailsPage extends StatelessWidget {
  static const routeName = '/Meal_Details';
  const MealDetailsPage({
    Key? key,
    required this.toggleFavorite,
    required this.isFavorite,
  }) : super(key: key);

  final Function toggleFavorite;
  final Function isFavorite;

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(ListView child) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final String id = routeArgs['id'];
    final Color color = routeArgs['color'];
    //use id to find the selected meal. This is just another way of solving this...
    final selectedMeals = dummyMeals.firstWhere(
      (meal) => meal.id == id,
    );
    final String imageUrl = selectedMeals.imageURL;
    final String title = selectedMeals.title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedMeals.ingredients[index],
                      ),
                    ),
                  );
                },
                itemCount: selectedMeals.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color,
                        foregroundColor: const Color.fromRGBO(20, 51, 51, 1),
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeals.steps[index],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: selectedMeals.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () => toggleFavorite(id),
        child: Icon(
          isFavorite(id)
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: color == Colors.red || color == Colors.pink
              ? Colors.white
              : Colors.red,
        ),
      ),
    );
  }
}
