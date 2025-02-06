import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/favourite_provider.dart';
import 'package:meal_app/model/filter.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filterProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    // TODO: implement build
    Widget activePage = CategoryScreen(
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favouriteMealProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        setScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
      body: activePage,
    );
  }
}
