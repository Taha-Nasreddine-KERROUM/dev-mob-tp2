import 'package:flutter/material.dart';
import 'package:meal_planner/components/meal_card.dart';

class IngredientsOfAMealScreen extends StatelessWidget {
  final Meal currentMeal;

  const IngredientsOfAMealScreen({
    super.key,
    required this.currentMeal,
  });

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
            "Ingredient list of the meal ${currentMeal.name}",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: currentMeal.listOfIngredients.length,
        itemBuilder: (context, i) {
          return Card(
            color: Colors.orange[100],
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                currentMeal.listOfIngredients[i],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}