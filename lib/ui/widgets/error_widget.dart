import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorMsg;
  const MyErrorWidget({
    super.key,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 50,
          ),
          const SizedBox(height: 20),
          Text('Error occured: $errorMsg'),
        ],
      ),
    );
  }
}
