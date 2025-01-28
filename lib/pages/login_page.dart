import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_button.dart';
import 'package:flutterauth/components/my_textfield.dart';
import 'package:flutterauth/components/square_tile.dart';
import 'package:flutterauth/pages/register_page.dart';
import 'package:flutterauth/services/auth_service.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Sign In function
  void signInUser() async {
    // Get instance of auth sevice
    final authService = AuthService();

    // Show dialog to user
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });

    try {
      await authService.signInWithEmailPassword(
          emailController.text, passwordController.text);
      Navigator.pop(context);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[700],
                title: Text(e.toString()),
              ));

      Navigator.pop(context);
    }
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //   // Pop the circle after sign up
    //   Navigator.pop(context);
    // } on FirebaseAuthException catch (e) {
    //   // Wrong Email
    //   Navigator.pop(context);

    //   if (e.code == 'user-not-found') {
    //     wrongEmailMessage();

    //     // Wrong Password
    //   } else if (e.code == "wrong-password") {
    //     wrongPasswordMessage();
    //   }
    // }

    // Pop the loading circle when finished loading
    // Navigator.pop(context);
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog.adaptive(
            title: Text("Incorrect Email"),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog.adaptive(
            title: Text("Incorrect Password"),
          );
        });
  }

  void forgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        backgroundColor: Colors.grey[700],
        title: const Text("User forgot password"),
      ),
    );
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
                    Text("Forgot password?"),
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
                  GestureDetector(
                      onTap: () {
                        AuthService().signInWithGoogle();
                        Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (context)=>HomePage(),));
                      },
                      child: SquareTile(imagePath: 'lib/images/google.png')),

                  const SizedBox(
                    width: 25,
                  ),

                  // Apple
                  SquareTile(imagePath: 'lib/images/apple.png')
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
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
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
