import 'package:flutter/material.dart';

// displaying an error message to the user
void displayMessageToTheUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
          ));
}
