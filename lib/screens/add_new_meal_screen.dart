import 'package:flutter/material.dart';
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';
import 'package:meal_planner/models/meal.dart';
import 'package:meal_planner/helpers/validators.dart';
import 'package:meal_planner/helpers/toast_helper.dart';

class AddNewMealScreen extends StatefulWidget {
  const AddNewMealScreen({super.key});

  @override
  State<AddNewMealScreen> createState() => _AddNewMealScreenState();
}

class _AddNewMealScreenState extends State<AddNewMealScreen> {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();

  List<TextEditingController> listOfTextField = [
    TextEditingController(),
  ];

  void addIngredientField() {
    setState(() {
      listOfTextField.add(TextEditingController());
    });
  }

  void removeIngredientField(int index) {
    if (listOfTextField.length > 1) {
      setState(() {
        listOfTextField[index].dispose();
        listOfTextField.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    mealNameController.dispose();
    imagePathController.dispose();
    for (var controller in listOfTextField) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String day = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Meal for $day',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: keyFormState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyTextField(
                tFHintText: "Enter meal's name",
                tFIcon: Icon(Icons.restaurant_menu),
                isObscure: false,
                tFController: mealNameController,
                tFValidator: (value) => fieldValidationFct(value, "Meal name"),
              ),
              SizedBox(height: 20),

              MyTextField(
                tFHintText: "Enter image path",
                tFIcon: Icon(Icons.image),
                isObscure: false,
                tFController: imagePathController,
                tFValidator: (value) => fieldValidationFct(value, "Image path"),
              ),
              SizedBox(height: 30),

              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List of ingredient',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                if (listOfTextField.length > 1) {
                                  removeIngredientField(listOfTextField.length - 1);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green),
                              onPressed: addIngredientField,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(thickness: 2),
                    SizedBox(height: 10),

                    ...List.generate(listOfTextField.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: MyTextField(
                          tFHintText: "Enter an ingredient",
                          tFIcon: Icon(Icons.shopping_basket),
                          isObscure: false,
                          tFController: listOfTextField[index],
                          tFValidator: (value) => fieldValidationFct(value, "Ingredient"),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: 30),

              MyElevatedButton(
                buttonLabel: "Add the meal",
                onPressedFct: () {
                  if (keyFormState.currentState!.validate()) {
                    List<String> ingredients = listOfTextField
                        .map((controller) => controller.text.trim())
                        .where((text) => text.isNotEmpty)
                        .toList();

                    Meal newMeal = Meal(
                      name: mealNameController.text,
                      imgPath: imagePathController.text,
                      listOfIngredient: ingredients,
                      identifier: '${day.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}',
                    );

                    displaySuccessToast("Meal added successfully!");

                    Navigator.pop(context, newMeal);
                  } else {
                    displayAToast();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}