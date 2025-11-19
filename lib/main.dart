import 'package:flutter/material.dart';
import 'package:meal_planner/screens/home_screen.dart';
import 'package:meal_planner/screens/login_screen.dart';
import 'package:meal_planner/screens/signup_screen.dart';
import 'package:meal_planner/screens/meals_of_a_day_screen.dart';
import 'package:meal_planner/screens/add_new_meal_screen.dart';
import 'package:meal_planner/screens/ingredients_ofa_meal_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Meal Planner',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),

      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Positioned(
              left: 10,
              bottom: 10,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.orange,
                child: Icon(
                  _themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Colors.white,
                ),
                onPressed: toggleTheme,
              ),
            ),
          ],
        );
      },

      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/mealsOfADay': (context) => MealsOfADayScreen(),
        '/addNewMeal': (context) => AddNewMealScreen(),
        '/ingredientsOfAMeal': (context) => IngredientsOfAMealScreen(),
      },
    );
  }
}
