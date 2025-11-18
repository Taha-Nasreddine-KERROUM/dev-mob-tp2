import 'package:flutter/material.dart';

class Meal {
  final String name;
  final String imgPath;
  final List<String> listOfIngredients;

  Meal({
    required this.name,
    required this.imgPath,
    this.listOfIngredients = const [],
  });
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              meal.imgPath,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 80,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.visibility),
                      color: Colors.orange,
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => IngredientsOfAMealScreen(currentMeal: meal),
                        //   ),
                        // );
                      },
                    ),
                  ),

                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}