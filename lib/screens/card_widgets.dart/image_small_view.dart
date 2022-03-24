import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unsafenote/model/image_model.dart';

class SmallImage extends StatelessWidget {
  SmallImage({Key? key, required this.image}) : super(key: key);
  ImageModel image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Container(
          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(File(image.imagePath)), fit: BoxFit.fitWidth),
          )),
    );
  }
}
