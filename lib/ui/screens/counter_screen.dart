import 'package:flutter/material.dart';
import 'package:icthub_new_repo/ui/widgets/my_form_field.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  TextEditingController number1Controller = TextEditingController();

  TextEditingController number2Controller = TextEditingController();

  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('sum is : $sum'),
            MyFormField(
              controller: number1Controller,
              hintText: 'Enter num 1',
            ),
            SizedBox(
              height: 20,
            ),
            MyFormField(
              controller: number2Controller,
              hintText: 'Enter num 2',
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final num1 = int.parse(number1Controller.text);
                final num2 = int.parse(number2Controller.text);
                sum = num1 + num2;
                setState(() {});
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
