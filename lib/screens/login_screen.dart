import 'package:flutter/material.dart';
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';
import 'package:meal_planner/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Welcome To my App",
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
              ),
              SizedBox(height: 20),

              MyTextField(
                tFHintText: "Password",
                tFIcon: Icon(Icons.lock),
                isObscure: true,
                tFController: pwdController,
              ),
              SizedBox(height: 15),

              MyTextButton(
                buttonLabel: "Forgot Password",
                onPressedFct: () {},
              ),
              SizedBox(height: 20),

              MyElevatedButton(
                buttonLabel: "Login",
                onPressedFct: () {},
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}