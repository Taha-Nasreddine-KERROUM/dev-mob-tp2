import 'package:flutter/material.dart';
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';
import 'package:meal_planner/helpers/validators.dart';
import 'package:meal_planner/helpers/display_validators.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: keyFormState,
            child: Column(
              children: [
                SizedBox(height: 60),

                Text(
                  "Ice Bear Likes Turtles",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/pfp.jpg'),
                  radius: 60,
                ),
                SizedBox(height: 30),

                MyTextField(
                  tFHintText: "Email",
                  tFIcon: Icon(Icons.email),
                  isObscure: false,
                  tFController: userController,
                  tFValidator: (value) => emailValidationFct(value),
                ),
                SizedBox(height: 20),

                MyTextField(
                  tFHintText: "Password",
                  tFIcon: Icon(Icons.lock),
                  isObscure: true,
                  tFController: pwdController,
                  tFValidator: (value) => fieldValidationFct(value, "Password"),
                ),
                SizedBox(height: 15),

                MyTextButton(
                  buttonLabel: "Forgot Password",
                  onPressedFct: () {
                  },
                ),
                SizedBox(height: 20),

                MyElevatedButton(
                  buttonLabel: "Login",
                  onPressedFct: () {
                    if (keyFormState.currentState!.validate()) {
                      displaySuccessToast("Login successful!");
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      displayAToast();
                    }
                  },
                ),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    MyTextButton(
                      buttonLabel: "Signup",
                      onPressedFct: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}