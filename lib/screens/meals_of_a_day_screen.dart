import 'package:flutter/material.dart';
import 'package:meal_planner/components/meal_card.dart';

class MealsOfADay {
  final String day;
  final List<Meal> listOfMeals;

  MealsOfADay({required this.day, required this.listOfMeals});
}

class MealsOfADayScreen extends StatefulWidget {
  final MealsOfADay dayAndItsListOfMeals;

  const MealsOfADayScreen({
    super.key,
    required this.dayAndItsListOfMeals,
  });

  @override
  State<MealsOfADayScreen> createState() => _MealsOfADayScreenState();
}

class _MealsOfADayScreenState extends State<MealsOfADayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Center(
          child: Text(
            "Details page for ${widget.dayAndItsListOfMeals.day}",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: widget.dayAndItsListOfMeals.listOfMeals.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        // padding: EdgeInsets.all(10),
        itemBuilder: (context, i) {
          return MealCard(
            meal: widget.dayAndItsListOfMeals.listOfMeals[i],
          );
        },
      ),
    );
  }
}