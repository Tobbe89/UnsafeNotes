import 'dart:ui';
import 'package:flutter/material.dart';

class ValidateOnDelete extends StatelessWidget {
  final String title;
  final Function onYes;
  final Function onNo;

  ValidateOnDelete(
      {required this.title, required this.onYes, required this.onNo});
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: textStyle,
            ),
          ),
          actions: <Widget>[
            Row(children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  child: const Text("Ja"),
                  onPressed: () {
                    onYes();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  child: const Text("Nej"),
                  onPressed: () {
                    onNo();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]),
          ],
        ));
  }
}
