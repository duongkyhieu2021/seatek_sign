import 'package:flutter/material.dart';

class ShowDialog {
  void showSuccessDialog(BuildContext context, String title, String message,
      Function()? onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String title, String message,
      Function()? onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
