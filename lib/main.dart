import 'package:flutter/material.dart';
import 'package:icthub_new_repo/ui/screens/hom_nav_bar.dart';

void main() {
  runApp(const NewProject());
}

class NewProject extends StatelessWidget {
  const NewProject({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeNavBar(),
    );
  }
}

///task 3
/// make bottom navigation bar with 2 screens
/// first screen is HomeScreen
/// second screen is CounterScreen
/// the HomeScreen will show the data of the products
/// from this api 'https://dummyjson.com/products'
/// in grid view with 2 columns
/// the CounterScreen will show a counter that increase by 1 when you click on the button
/// the button will be in the center of the screen [ElevatedButton] with text 'Increase'
