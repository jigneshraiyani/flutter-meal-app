import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/model/category.dart';
import 'package:meal_app/model/meal.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key, 
    required this.availableMeals
    });

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filterdMeal = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: filterdMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      padding: EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
