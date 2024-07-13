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
