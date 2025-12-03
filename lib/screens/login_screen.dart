import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';
import 'package:meal_planner/helpers/validators.dart';
import 'package:meal_planner/helpers/display_validators.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  LoginScreen({super.key});

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: pwdController.text,
      );

      if (userCredential.user!.emailVerified) {
        if (context.mounted) {
          displaySuccessToast("Login successful!");
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please verify your email address. Check your inbox for the verification link.'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Resend',
                textColor: Colors.white,
                onPressed: () async {
                  await userCredential.user!.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Verification email sent!')),
                  );
                },
              ),
            ),
          );
          await FirebaseAuth.instance.signOut();
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (e.code == 'user-disabled') {
        message = 'This user account has been disabled.';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> forgotPassword(BuildContext context) async {
    String? emailValidation = emailValidationFct(emailController.text);

    if (emailValidation != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('If an account exists with this email, a password reset link has been sent!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';

      if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'missing-email') {
        message = 'Please enter an email address.';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
                  tFController: emailController,
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
                    forgotPassword(context);
                  },
                ),
                SizedBox(height: 20),

                MyElevatedButton(
                  buttonLabel: "Login",
                  onPressedFct: () {
                    if (keyFormState.currentState!.validate()) {
                      displaySuccessToast("Login successful!");
                      login(context);
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