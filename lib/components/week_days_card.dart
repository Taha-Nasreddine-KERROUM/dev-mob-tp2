import 'package:flutter/material.dart';
import 'package:meal_planner/models/meals_of_a_day_meals.dart';
import 'package:meal_planner/models/meal.dart';

class WeekDaysCard extends StatelessWidget {
  final MealsOfADay dayAndItsMealsList;
  final Function(Meal)? onMealAdded;

  const WeekDaysCard({
    super.key,
    required this.dayAndItsMealsList,
    this.onMealAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  dayAndItsMealsList.day,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      '/mealsOfADay',
                      arguments: dayAndItsMealsList,
                    );
                  },
                  color: Colors.orange,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    final newMeal = await Navigator.pushNamed(
                      context,
                      '/addNewMeal',
                      arguments: dayAndItsMealsList.day,
                    );

                    if (newMeal != null && newMeal is Meal) {
                      onMealAdded?.call(newMeal);
                    }
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}