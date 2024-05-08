import 'package:flutter/material.dart';
import 'package:seshat/models/note.dart';
import 'package:seshat/utils/icons.dart';
import 'package:seshat/db/db.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<AddNote> createState() => _AddNotePage();
}

class _AddNotePage extends State<AddNote> {
  String text = '';
  String title = 'Untitled';

  void _updateText(String newText) {
    setState(() {
      text = newText;
    });
  }

  void _updateTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  Future<void> addNote() async {
    await insertNote(Note(title: title, text: text));
  }

  @override
  Widget build(BuildContext context) {
    final double height = widget.height;
    final double width = widget.width;
    const double topBarSize = 120.0;
    final double bodySize = height - topBarSize;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
          )),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
                height: topBarSize,
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(26, 10, 26, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                              onPressed: () =>
                                  {addNote(), Navigator.pop(context)},
                              icon: back(),
                            )),
                      ),
                      SizedBox(
                        width: width,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: TextField(
                              autocorrect: true,
                              maxLength: 20,
                              keyboardType: TextInputType.text,
                              onChanged: (value) => {_updateTitle(value)},
                              cursorColor:
                                  Theme.of(context).colorScheme.secondary,
                              textAlign: TextAlign.center,
                              showCursor: true,
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  hintText: "Untitled",
                                  contentPadding: EdgeInsets.all(0),
                                  hintMaxLines: 1,
                                  border: InputBorder.none,
                                  counterText: '',
                                  hintStyle: TextStyle(
                                      fontSize: 32,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold)),
                            )),
                      )
                    ],
                  ),
                )),
            Container(
                color: Theme.of(context).colorScheme.primary,
                height: bodySize,
                width: width,
                padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  //TODO: set the cursor to be always above the keyboard
                  child: TextField(
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 20000,
                      onChanged: (value) => {_updateText(value)},
                      showCursor: true,
                      style:
                          const TextStyle(fontSize: 24, fontFamily: 'Roboto'),
                      decoration: const InputDecoration(
                          hintText: "Type Something...",
                          contentPadding: EdgeInsets.all(0),
                          hintMaxLines: 1,
                          border: InputBorder.none,
                          counterText: '',
                          hintStyle: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold))),
                )),
          ],
        ),
      ),
    );
  }
}
