import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
