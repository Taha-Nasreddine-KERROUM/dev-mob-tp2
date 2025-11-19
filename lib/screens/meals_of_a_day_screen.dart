import 'package:flutter/material.dart';
import 'package:meal_planner/models/meals_of_a_day_meals.dart';
import 'package:meal_planner/models/meal.dart';
import 'package:meal_planner/components/meal_card.dart';

class MealsOfADayScreen extends StatefulWidget {
  const MealsOfADayScreen({super.key});

  @override
  State<MealsOfADayScreen> createState() => _MealsOfADayScreenState();
}

class _MealsOfADayScreenState extends State<MealsOfADayScreen> {
  @override
  Widget build(BuildContext context) {
    final dayAndItsListOfMeals =
    ModalRoute.of(context)?.settings.arguments as MealsOfADay;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${dayAndItsListOfMeals.day} Meals',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: dayAndItsListOfMeals.listOfMealsForADay.length,
          itemBuilder: (context, index) {
            return MealCard(
              meal: dayAndItsListOfMeals.listOfMealsForADay[index],

              onDelete: () {
                setState(() {
                  dayAndItsListOfMeals.listOfMealsForADay.removeAt(index);
                });
              },
            );
          },
        ),
      ),
    );
  }
}