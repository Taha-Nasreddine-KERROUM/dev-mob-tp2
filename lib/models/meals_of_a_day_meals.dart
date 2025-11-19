import 'package:meal_planner/models/meal.dart';

class MealsOfADay {
  final String day;
  final List<Meal> listOfMealsForADay;

  MealsOfADay({
    required this.day,
    required this.listOfMealsForADay,
  });
}