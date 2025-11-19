import 'package:flutter/material.dart';
import 'package:meal_planner/components/week_days_card.dart';
import 'package:meal_planner/models/meal.dart';
import 'package:meal_planner/models/meals_of_a_day_meals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MealsOfADay> weekDaysList = [
    MealsOfADay(
      day: 'Saturday',
      listOfMealsForADay: [
        Meal(
          name: 'Pancakes',
          imgPath: 'assets/images/pan.jpg',
          listOfIngredient: ['potato', 'zucchini', 'flour', 'egg', 'egg wash', 'dipping sauce'],
          identifier: 'sat_breakfast',
        ),
      ],
    ),
    MealsOfADay(
      day: 'Sunday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Monday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Tuesday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Wednesday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Thursday',
      listOfMealsForADay: [],
    ),
    MealsOfADay(
      day: 'Friday',
      listOfMealsForADay: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Center(
          child: Text(
            "Home page",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: weekDaysList.length,
        itemBuilder: (context, index) {
          return WeekDaysCard(
            dayAndItsMealsList: weekDaysList[index],
            onMealAdded: (Meal meal) {
              setState(() {
                weekDaysList[index].listOfMealsForADay.add(meal);
              });
            },
          );
        },
      ),
    );
  }
}