import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// keep your own imports
import 'package:meal_planner/components/my_textfield.dart';
import 'package:meal_planner/components/my_buttons.dart';
import 'package:meal_planner/helpers/validators.dart';
import 'package:meal_planner/helpers/display_validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    super.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      print('Starting signup process...');
      final email = emailController.text.trim();
      final password = pwdController.text;
      final username = userController.text.trim();

      print('Email: $email');

      // Create user with email and password
      final UserCredential userCred =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User created successfully: ${userCred.user?.uid}');

      // Optionally set display name
      if (userCred.user != null) {
        await userCred.user!.updateDisplayName(username);
        // reload to make sure local user object is updated
        await userCred.user!.reload();
      }

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && !currentUser.emailVerified) {
        await currentUser.sendEmailVerification();
        print('Verification email sent to $email');
      } else {
        print('No current user or already verified.');
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account created! Please check your email to verify your account.',
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );

        Navigator.pushReplacementNamed(context, '/login');
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      String message = 'An error occurred';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak (min 6 chars).';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/password accounts are not enabled in Firebase.';
      } else if (e.code == 'network-request-failed') {
        message = 'Network error. Check your internet connection.';
      } else {
        message = e.message ?? 'Unknown error';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e, st) {
      print('General error: $e');
      print(st);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
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
                  tFValidator: (value) =>
                      pwdConfirmValidationFct(value, pwdController.text),
                ),
                SizedBox(height: 30),
                _isLoading
                    ? CircularProgressIndicator()
                    : MyElevatedButton(
                  buttonLabel: "Signup",
                  onPressedFct: () async {
                    if (_formKey.currentState!.validate()) {
                      await signUp(context);
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Google sign-in not implemented yet')),
                    );
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
