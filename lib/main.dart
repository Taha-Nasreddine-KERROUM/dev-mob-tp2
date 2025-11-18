import 'package:flutter/material.dart';
import 'package:meal_planner/screens/home_screen.dart';
import 'package:meal_planner/screens/login_screen.dart';
import 'package:meal_planner/screens/add_new_meal_screen.dart';
import 'package:meal_planner/screens/meals_of_a_day_screen.dart';
import 'package:meal_planner/components/meal_card.dart';
import 'package:meal_planner/screens/ingredients_ofa_meal_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      // home: HomeScreen(
      //   weekDaysList: [
      //     'Saturday',
      //     'Sunday',
      //     'Monday',
      //     'Tuesday',
      //     'Wednesday',
      //     'Thursday',
      //     'Friday',
      //   ],
      // ),

      // home: LoginScreen(),

      //home: AddNewMealScreen(),

      home: MealsOfADayScreen(
        dayAndItsListOfMeals: MealsOfADay(
          day: 'Monday',
          listOfMeals: [
            Meal(
              name: 'BouZelouf',
              imgPath: 'assets/images/OIP.webp',
              listOfIngredients: ['Sheep', 'salt', 'water'],
            ),
            Meal(
              name: 'BZ prim',
              imgPath: 'assets/images/OIP (1).webp',
              listOfIngredients: ['cow', 'Rice', 'Vegetables'],
            ),
            Meal(
              name: 'BZ royal',
              imgPath: 'assets/images/OIP (2).webp',
              listOfIngredients: ['camel', 'Salad', 'Potatoes'],
            ),
          ],
        ),
      ),

      // home: IngredientsOfAMealScreen(
      //   currentMeal: Meal(
      //     name: 'BouZelouf',
      //     imgPath: 'assets/images/OIP.webp',
      //     listOfIngredients: [
      //       'sheep',
      //       'water',
      //       'salt',
      //       'onion',
      //       'Black pepper',
      //     ],
      //   ),
      // ),


      debugShowCheckedModeBanner: false,
    );
  }
}