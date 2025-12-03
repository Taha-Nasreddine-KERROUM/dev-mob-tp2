import 'package:hive/hive.dart';
import 'package:meal_planner/models/meal.dart';

part 'meals_of_a_day_meals.g.dart';

@HiveType(typeId: 1)
class MealsOfADay {
  @HiveField(0)
  final String day;

  @HiveField(1)
  final List<Meal> listOfMealsForADay;

  MealsOfADay({
    required this.day,
    required this.listOfMealsForADay,
  });
}