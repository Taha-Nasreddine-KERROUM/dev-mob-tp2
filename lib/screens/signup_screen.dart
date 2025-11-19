import 'package:flutter/material.dart';
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';
import 'package:meal_planner/helpers/validators.dart';
import 'package:meal_planner/helpers/toast_helper.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  SignupScreen({super.key});

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
                SizedBox(height: 40),

                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                MyTextField(
                  tFHintText: "Username",
                  tFIcon: Icon(Icons.person),
                  isObscure: false,
                  tFController: userController,
                  tFValidator: (value) => usernameValidationFct(value),
                ),
                SizedBox(height: 20),

                MyTextField(
                  tFHintText: "Email",
                  tFIcon: Icon(Icons.email),
                  isObscure: false,
                  tFController: emailController,
                  tFValidator: (value) => emailValidationFct(value),
                ),
                SizedBox(height: 20),

                MyTextField(
                  tFHintText: "Password",
                  tFIcon: Icon(Icons.lock),
                  isObscure: true,
                  tFController: pwdController,
                  tFValidator: (value) => pwdValidationFct(value),
                ),
                SizedBox(height: 20),

                MyTextField(
                  tFHintText: "Confirm Password",
                  tFIcon: Icon(Icons.lock),
                  isObscure: true,
                  tFController: confirmPwdController,
                  tFValidator: (value) => pwdConfirmValidationFct(value, pwdController.text),
                ),
                SizedBox(height: 30),

                MyElevatedButton(
                  buttonLabel: "Signup",
                  onPressedFct: () {
                    if (keyFormState.currentState!.validate()) {
                      displaySuccessToast("Signup successful!");
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      displayAToast();
                    }
                  },
                ),
                SizedBox(height: 15),

                Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),

                MyElevatedButton(
                  buttonLabel: "Sign up with Google",
                  onPressedFct: () {
                  },
                ),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    MyTextButton(
                      buttonLabel: "Login",
                      onPressedFct: () {
                        Navigator.pushReplacementNamed(context, '/login');
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