import 'package:flutter/widgets.dart';
import 'package:unsafenote/db/NoteDb.dart';
import 'package:unsafenote/model/image_model.dart';

class ImageProviderr extends ChangeNotifier {
  late List<ImageModel> images = [];

  ImageProviderr() {
    getImages;
  }

  Future<void> get getImages async {
    images = await NoteDb.instance.readAllImages();
    notifyListeners();
  }

  List<ImageModel> getImageWithId(int id) {
    return images.where((element) => element.id == id).toList();
  }

  void addImage(ImageModel image) {
    NoteDb.instance.createImage(image);
  }
}
