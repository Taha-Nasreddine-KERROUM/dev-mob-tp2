import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
                    try {
                      final dayMealsBox = await Hive.openBox<MealsOfADay>('MealsBDD');
                      final mealsData = dayMealsBox.get(dayAndItsMealsList.day);

                      if (mealsData != null) {
                        await Navigator.pushNamed(
                          context,
                          '/mealsOfADay',
                          arguments: mealsData,
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error loading meals: $e')),
                      );
                    }
                  },
                  color: Colors.orange,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    try {
                      final newMeal = await Navigator.pushNamed(
                        context,
                        '/addNewMeal',
                        arguments: dayAndItsMealsList.day,
                      );

                      if (newMeal != null && newMeal is Meal) {
                        final dayMealsBox = await Hive.openBox<MealsOfADay>('MealsBDD');

                        final currentData = dayMealsBox.get(dayAndItsMealsList.day);

                        if (currentData != null) {
                          currentData.listOfMealsForADay.add(newMeal);

                          await dayMealsBox.put(dayAndItsMealsList.day, currentData);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Meal added successfully!')),
                          );
                        }
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error adding meal: $e')),
                      );
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