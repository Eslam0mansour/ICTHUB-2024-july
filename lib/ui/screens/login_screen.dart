import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthub_new_repo/core/logic/extensions.dart';
import 'package:icthub_new_repo/data/data_sourec/auth.dart';
import 'package:icthub_new_repo/ui/screens/hom_nav_bar.dart';
import 'package:icthub_new_repo/ui/screens/signup_screen.dart';
import 'package:icthub_new_repo/ui/widgets/my_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to our app',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                'assets/app_logo.svg',
                height: 100,
              ),
              const SizedBox(height: 20),
              MyFormField(
                controller: emailController,
                hintText: 'Please enter your email',
                label: 'Email',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  } else if (value.isNotValidEmail()) {
                    return 'Please enter a valid email';
                  }
                },
              ),
              const SizedBox(height: 20),
              MyFormField(
                controller: passwordController,
                hintText: 'Please enter your password',
                label: 'Password',
                prefixIcon: Icons.lock,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  } else if (value.isNotValidPassword()) {
                    return 'Password must be at least 6 characters';
                  }
                },
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (context, setState) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        AuthDataSource.signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        ).then(
                          (value) {
                            setState(() {
                              isLoading = false;
                            });
                            if (value != null) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeNavBar(),
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    AuthDataSource.errorMessage,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('login'),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text('Register'),
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
