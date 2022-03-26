import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unsafenote/model/image_model.dart';

class SmallImage extends StatelessWidget {
  SmallImage({Key? key, required this.imagePath}) : super(key: key);
  String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(File(imagePath)), fit: BoxFit.fitWidth),
          )),
    );
  }
}
