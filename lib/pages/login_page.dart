// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_button.dart';
import 'package:flutterauth/components/my_textfield.dart';
import 'package:flutterauth/components/square_tile.dart';
import 'package:flutterauth/services/auth_service.dart';
import 'package:flutterauth/utils/utils.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Sign In function
  void signInUser() async {
    // Get instance of AuthService
    final authService = AuthService();

    // Show dialog to the user
    await showLoadingDialog(context);

    // Attempt Sign In
    try {
      // Await sign-in attempt
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      // Close the dialog after successful sign-in
      Navigator.pop(context);
    } catch (e) {
      // Close the dialog on error
      Navigator.pop(context);

      // Show the error message to the user
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
      showFlashError(context, e.toString());
    }
  }

//Wrong Email
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog.adaptive(
            title: Text("Incorrect Email"),
          );
        });
  }

// Wroen Password
  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog.adaptive(
            title: Text("Incorrect Password"),
          );
        });
  }

  // Forgor password
  void forgotPassword() async {
    // uthservice Instance
    final authService = AuthService();

    try {
      await authService.forgotPassword(emailController.text);
      // Show a success message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password reset email sent!')));
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Logo
              SizedBox(
                height: 30,
              ),
              Icon(
                Icons.lock,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),

              //Welcome Back message
              Text(
                "Welcome back, you've been missed...",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),

              SizedBox(
                height: 30,
              ),

              // The texfields for the user to enter data
              // Username
              MyTextfield(
                controller: emailController,
                obscureText: false,
                hintText: "Enter your email",
              ),

              SizedBox(
                height: 25,
              ),
              // Password
              MyTextfield(
                controller: passwordController,
                obscureText: true,
                hintText: "Enter your password",
              ),

              SizedBox(
                height: 10,
              ),

              // Forgot Password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: forgotPassword, child: Text("Forgot password?")),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              // Sign In Button
              MyButton(
                text: "Sign In",
                onTap: signInUser,
              ),

              SizedBox(
                height: 10,
              ),

              // Or Continue with
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Google and Apple Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google
                  SquareTile(
                    imagePath: 'lib/images/google.png',
                    onTap: () => AuthService().signInWithGoogle(),
                  ),

                  const SizedBox(
                    width: 25,
                  ),

                  // Apple
                  SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png'),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              // Not a member? Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    // onTap: () {
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => RegisterPage(),
                    //       ));
                    // },
                    child: Text(
                      "Register now",
                      style: TextStyle(
                          color: Colors.blue[700], fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
