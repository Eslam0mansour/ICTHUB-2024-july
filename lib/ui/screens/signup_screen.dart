import 'package:flutter/material.dart';
import 'package:icthub_new_repo/core/logic/extensions.dart';
import 'package:icthub_new_repo/data/data_sourec/auth.dart';
import 'package:icthub_new_repo/ui/screens/hom_nav_bar.dart';
import 'package:icthub_new_repo/ui/widgets/my_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFormField(
                controller: nameController,
                hintText: 'Please enter your name',
                label: 'Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                },
              ),
              const SizedBox(height: 20),
              MyFormField(
                controller: phoneController,
                hintText: 'Please enter your phone number',
                label: 'Phone',
                prefixIcon: Icons.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone is required';
                  }
                },
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
                    return 'Please enter a valid password';
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
                        AuthDataSource.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          phone: phoneController.text,
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
                        : const Text('Register'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
