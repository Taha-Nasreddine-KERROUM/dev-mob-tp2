import 'package:flutter/material.dart';
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';

class AddNewMealScreen extends StatefulWidget {
  const AddNewMealScreen({super.key});

  @override
  State<AddNewMealScreen> createState() => _AddNewMealScreenState();
}

class _AddNewMealScreenState extends State<AddNewMealScreen> {
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();

  List<TextEditingController> listOfTextField = [];

  @override
  void dispose() {
    mealNameController.dispose();
    imagePathController.dispose();
    for (var controller in listOfTextField) {
      controller.dispose();
    }
    super.dispose();
  }

  void addTextField() {
    setState(() {
      listOfTextField.add(TextEditingController());
    });
  }

  void deleteLastTextField() {
    if (listOfTextField.isNotEmpty) {
      setState(() {
        listOfTextField.last.dispose();
        listOfTextField.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adding a new meal",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              MyTextField(
                tFHintText: "Enter meals name:",
                tFIcon: Icon(Icons.restaurant_menu),
                isObscure: false,
                tFController: mealNameController,
              ),
              SizedBox(height: 20),

              MyTextField(
                tFHintText: "Enter image path:",
                tFIcon: Icon(Icons.image),
                isObscure: false,
                tFController: imagePathController,
              ),
              SizedBox(height: 20),

              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "List of ingredients",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: deleteLastTextField,
                        ),

                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: addTextField,
                        ),
                      ],
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listOfTextField.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: MyTextField(
                            tFHintText: "Ingredient ${i + 1}",
                            tFIcon: Icon(Icons.food_bank),
                            isObscure: false,
                            tFController: listOfTextField[i],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              MyElevatedButton(
                buttonLabel: "Add the meal",
                onPressedFct: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}