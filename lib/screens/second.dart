import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:unsafenote/db/NoteDb.dart';
import 'package:unsafenote/main.dart';
import 'package:unsafenote/model/image_model.dart';
import 'package:unsafenote/model/note_model.dart';
import 'package:unsafenote/provider/image_provider.dart';
import 'package:unsafenote/provider/note_provider.dart';
import 'package:unsafenote/screens/card_widgets.dart/custom_button.dart';
import 'package:unsafenote/screens/first.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //late String? header;
  late String content;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  File? image;
  late List<String?> imageList;
  @override
  void initState() {
    super.initState();
  }

  Future addImageToList(String? imagePath) async {
    imageList.add(imagePath);
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> addSong(BuildContext context, List<String?> image) async {
    final note = NoteModel(content: content, createdTime: DateTime.now());

    NoteModel _note = await context.read<NoteProvider>().addNote(note);

    if (image.isNotEmpty) {
      for (int i = 0; i < image.length; i++) {
        final _image = ImageModel(
            imagePath: image[i]!,
            noteId: _note.id!,
            createdTime: DateTime.now());
        context.read<ImageProviderr>().addImage(_image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              // TextFormField(
              //   // validator: (value) {
              //   //   if (value?.isEmpty ?? true) {
              //   //     return "Skriv din header";
              //   //   } else {
              //   //     return null;
              //   //   }
              //   // },
              //   onChanged: (value) => {setState(() => header = value)},
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Add here:",
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(),
                  ),
                  expands: false,
                  minLines: 1,
                  maxLines: 8,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Skriv din note";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => {setState(() => content = value)},
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.note_add,
                size: 150,
                color: Color(0xFFE0E1E9),
              ),
            ],
          )),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: const Icon(
              Icons.camera_alt,
            )),
        CustomButton(
          text: "Save",
          onSelected: () => {
            if (!_formkey.currentState!.validate())
              {_formkey.currentState!.save()}
            else
              {
                addSong(context, imageList),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()))
              }
          },
        ),
      ]),
    );
  }
}
