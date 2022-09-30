import 'package:flutter/material.dart';

import '../pages/filters_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _buildListTile(
      {required String title,
      required IconData icon,
      VoidCallback? onTap,
      required BuildContext context}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: size.height * 0.25,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(20)),
            ),
            child: const Text(
              'Deli Meals',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          _buildListTile(
            title: 'Meals',
            context: context,
            icon: Icons.restaurant_rounded,
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          _buildListTile(
              title: 'Filters',
              icon: Icons.settings_rounded,
              context: context,
              onTap: () => Navigator.pushReplacementNamed(context, FiltersPage.routeName))
        ],
      ),
    );
  }
}
