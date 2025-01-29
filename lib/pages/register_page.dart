import 'package:flutter/material.dart';
import 'package:flutterauth/pages/login_page.dart';
import 'package:flutterauth/services/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void registerUser() async {
    // Prepare the data
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

  //   // Confirm Password
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }

   // Show dialog to user
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });

  // Attempt sign up..
    try {
      await AuthService().signUpWithEmailAndPassword(
            email, password);
      // Pop the page
      Navigator.pop(context);
    } catch (e) {
      // Catch any errors
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
      // Pop the circle
      Navigator.pop(context);
    }
  }

  // Google sign In
  void googleSignIn() async {
     // Show dialog to user
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });

    try {
      await AuthService().signInWithGoogle();
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
      // Pop the circle
      Navigator.pop(context);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //Logo
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.lock_open,
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),

          //Welcome Back message
          Text(
            "Hello there, welcome to this platform!",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
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
            height: 15,
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

          MyTextfield(
              controller: confirmPasswordController,
              hintText: "Confirm your password",
              obscureText: true),

          SizedBox(
            height: 10,
          ),

          // // Forgot Password?
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text("Forgot password?"),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),

          // Sign In Button
          MyButton(
            text: "Register",
            onTap: registerUser,
            // onTap: () {
            //   AuthService().signUpWithEmailAndPassword(
            //       emailController.text, passwordController.text);

            //   Navigator.pushReplacement(context, 
            //       MaterialPageRoute(builder: (context)=>HomePage(),));
            // },
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
                    onTap: googleSignIn,
                    // onTap:()=>AuthService().signInWithGoogle(),
                    imagePath: 'lib/images/google.png'),

                  const SizedBox(
                    width: 25,
                  ),

                  // Apple
                  SquareTile(
                    onTap: (){},
                    imagePath: 'lib/images/apple.png')
                ],
              ),

              SizedBox(
                height: 20,
              ),

          SizedBox(height: 15,),
          // Already a member? Login
           Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
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
                            builder: (context) => LoginPage(
                              onTap: (){},
                            ),
                          ));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue[700], fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
        ]),
      ),
    ));
  }
}
