import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onSelected, required this.text})
      : super(key: key);

  final Function() onSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF00CC99)),
              overlayColor: MaterialStateProperty.all(const Color(0xFFE0E1E9)),
            ),
            onPressed: () {
              onSelected();
            },
            child: Text(
              text,
              style: TextStyle(color: Colors.black),
            )));
  }
}
