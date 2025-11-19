import 'package:flutter/material.dart';
import 'package:meal_planner/models/meal.dart';

class IngredientsOfAMealScreen extends StatelessWidget {
  const IngredientsOfAMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMeal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ingredients of ${currentMeal.name}',
          style: TextStyle(
            fontSize: 18,
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
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.orange[100],
            ),
            child: Image.asset(
              currentMeal.imgPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 100,
                    color: Colors.orange[800],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              currentMeal.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: currentMeal.listOfIngredient.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amber[100],
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      currentMeal.listOfIngredient[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}