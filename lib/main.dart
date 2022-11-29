import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/receipe.dart';
import './screens/filters_screen.dart';
import './screens/receipe_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_selected_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Receipe> _availableRecipe = dummyMeals;
  List<Receipe> _favoriteRecipe = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableRecipe = dummyMeals.where((receipe) {
        if (_filters['gluten'] == true && !receipe.isGlutenFree) return false;
        if (_filters['lactose'] == true && !receipe.isLactoseFree) return false;
        if (_filters['vegan'] == true && !receipe.isVegan) return false;
        if (_filters['vegetarian'] == true && !receipe.isVegetarian)
          return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteRecipe.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteRecipe.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteRecipe
            .add(dummyMeals.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isRecipeFavorite(String mealId) {
    return _favoriteRecipe.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => TabsScreen(_favoriteRecipe),
        CategorySelectedScreen.routeName: (context) =>
            CategorySelectedScreen(_availableRecipe),
        ReceipeDetailsScreen.routeName: (context) =>
            ReceipeDetailsScreen(_toggleFavorite, _isRecipeFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
      // home: CategoryScreen(),
      title: "Food Corner",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
      ),
    );
  }
}
