import 'package:flutter/material.dart';

class ConfirmationDialogOverlay extends StatelessWidget {
  const ConfirmationDialogOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Material(
        color: Colors.black,
        child: Center(
          child: AlertDialog(
            backgroundColor: Colors.black,
            content: const Text(
              "Quit game?",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
