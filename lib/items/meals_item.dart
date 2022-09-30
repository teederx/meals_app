import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../pages/meal_details_page.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({
    Key? key,
    required this.title,
    required this.imageURL,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
    required this.color,
  }) : super(key: key);

  final String id;
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Color color;

  String get complexityText {
    switch (complexity) {
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.simple:
        return 'Simple';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.luxurious:
        return 'Luxurious';
      case Affordability.pricey:
        return 'Pricey';
      default:
        return 'unknown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.pushNamed(
      context,
      MealDetailsPage.routeName,
      arguments: {
        'id': id,
        'color': color,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageURL,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.black54,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_sharp),
                      const SizedBox(width: 6),
                      Text('$duration mins'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work_outline_rounded),
                      const SizedBox(width: 6),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_rounded),
                      const SizedBox(width: 6),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
