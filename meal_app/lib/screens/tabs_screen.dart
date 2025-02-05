import 'package:flutter/material.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/screens/filter_screen.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';

    void _showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    void _onToggleFavorite(Meal meal) {
      if (_favoriteMeals.contains(meal)) {
        setState(() {
          _favoriteMeals.remove(meal);
        });
        _showInfoMessage('Meal is no longer a favorite.');
      } else {
        setState(() {
          _favoriteMeals.add(meal);
        });
        _showInfoMessage('Marked as a favorite!');
      }
    }

    // TODO: implement build
    Widget activePage = CategoryScreen(
      onToggleFavorite: _onToggleFavorite,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _onToggleFavorite,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        setScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
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
