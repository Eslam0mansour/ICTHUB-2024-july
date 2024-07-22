import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_new_repo/firebase_options.dart';
import 'package:icthub_new_repo/ui/screens/hom_nav_bar.dart';
import 'package:icthub_new_repo/ui/screens/login_screen.dart';
import 'package:logger/logger.dart';

Future<bool> getProductsData() async {
  var response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    try {
      Map<String, dynamic> data = jsonDecode(response.body);

      List<dynamic> productsList = data['products'];

      for (Map<String, dynamic> item in productsList) {
        saveItemToProductsCollection(item);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
  {
    return false;
  }
}

Future<void> saveItemToProductsCollection(Map<String, dynamic> item) async {
  await FirebaseFirestore.instance.collection('products').add(item);
}
var log = Logger(
  printer: PrettyPrinter(),

);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await getProductsData();
  runApp(const NewProject());
}

class NewProject extends StatelessWidget {
  const NewProject({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeNavBar()
          : const LoginScreen(),
    );
  }
}

///task 3
/// make bottom navigation bar with 2 screens
/// first screen is HomeScreen
/// second screen is CounterScreen
/// the HomeScreen will show the data of the products
/// from this api 'https://fakestoreapi.com/products'
/// in grid view with 2 columns
/// the CounterScreen will show a counter that increase by 1 when you click on the button
/// the button will be in the center of the screen [ElevatedButton] with text 'Increase'
