import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:unsafenote/model/image_model.dart';
import 'package:unsafenote/model/note_model.dart';
import 'package:unsafenote/provider/image_provider.dart';
import 'package:unsafenote/provider/note_provider.dart';
import 'package:unsafenote/screens/card_widgets.dart/dialog.dart';
import 'package:unsafenote/screens/card_widgets.dart/image_small_view.dart';

class NoteElement extends StatelessWidget {
  const NoteElement({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  void deleteOnHold(BuildContext context) {
    context.read<NoteProvider>().deleteNote(note.id);
  }

  List<ImageModel> getImagesWithId(BuildContext context, int id) {
    return context.read<ImageProviderr>().getImageWithId(id);
  }

  _onDelteDialogButton(BuildContext context) {
    ValidateOnDelete validate = ValidateOnDelete(
        title: "Delete?",
        onYes: () async {
          deleteOnHold(context);
        },
        onNo: () {});

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return validate;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _onDelteDialogButton(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ]),
          child: ListTile(
            //leading: Icon(Icons.music_note),
            subtitle: Padding(
              padding:
                  const EdgeInsets.only(left: 2, top: 5, bottom: 5, right: 2),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          note.content,
                        )
                      ]),
                ),
                if (Provider.of<ImageProviderr>(context)
                    .getImageWithId(note.id!)
                    .isNotEmpty)
                  //   Column(children: [
                  //     Scrollbar(
                  //       child: buildImages(context),
                  //     ),
                  //   ])

                  Expanded(
                      flex: 1,
                      child: Column(children: [
                        Scrollbar(
                          child: buildImages(context),
                        ),
                      ]))
              ]),
            ),
          ),
          margin: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget buildImages(BuildContext context) =>
      Consumer<ImageProviderr>(builder: (context, value, child) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: value.getImageWithId(note.id!).length,
            itemBuilder: (context, index) {
              final _image = value.getImageWithId(note.id!)[index];
              return SmallImage(imagePath: _image.imagePath);
            });
      });
}
