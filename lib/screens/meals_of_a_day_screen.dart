import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_planner/models/meals_of_a_day_meals.dart';
import 'package:meal_planner/models/meal.dart';
import 'package:meal_planner/components/meal_card.dart';

class MealsOfADayScreen extends StatefulWidget {
  const MealsOfADayScreen({super.key});

  @override
  State<MealsOfADayScreen> createState() => _MealsOfADayScreenState();
}

class _MealsOfADayScreenState extends State<MealsOfADayScreen> {
  late MealsOfADay dayAndItsListOfMeals;

  Future<void> deleteAMeal(Meal mealToRemove, MealsOfADay dayAndItsListOfMeals) async {
    try {
      setState(() {
        dayAndItsListOfMeals.listOfMealsForADay.remove(mealToRemove);
      });

      Box<MealsOfADay> dayMealsBox = Hive.box<MealsOfADay>('MealsBDD');

      await dayMealsBox.put(dayAndItsListOfMeals.day, dayAndItsListOfMeals);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meal deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting meal: $e')),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
              (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

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
            onPressed: signOut,
          ),
        ],
      ),
      body: dayAndItsListOfMeals.listOfMealsForADay.isEmpty
          ? Center(
        child: Text(
          'No meals for this day.\nAdd one using the + button!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : Padding(
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
              onDeleteMeal: () => deleteAMeal(
                dayAndItsListOfMeals.listOfMealsForADay[index],
                dayAndItsListOfMeals,
              ),
            );
          },
        ),
      ),
    );
  }
}