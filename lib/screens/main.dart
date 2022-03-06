import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text(
        "Main",
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget buildNote(BuildContext context) =>
  //     ListView.builder(itemBuilder: () {});
}
