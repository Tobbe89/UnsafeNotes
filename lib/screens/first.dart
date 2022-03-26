import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsafenote/provider/note_provider.dart';
import 'package:unsafenote/screens/card_widgets.dart/dialog.dart';
import 'package:unsafenote/screens/card_widgets.dart/note_element.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: Scaffold(
                // backgroundColor: Colors.blue[900],
                body: value.getNoteList().isEmpty
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_right,
                                size: 100,
                              ),
                              Text("Swipe right")
                            ]),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            Scrollbar(
                                controller: _scroll,
                                isAlwaysShown: true,
                                child: buildNote(context)),
                          ])),
          ),
        );
      },
    );
  }

  Widget buildNote(BuildContext context) =>
      Consumer<NoteProvider>(builder: (context, value, child) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            controller: _scroll,
            shrinkWrap: true,
            itemCount: value.getNoteList().length,
            itemBuilder: (context, index) {
              final _note = value.getNoteList()[index];
              return NoteElement(note: _note);
            });
      });
}
