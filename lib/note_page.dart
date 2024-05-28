import 'package:flutter/material.dart';
import 'package:seshat/db/db.dart';
import 'package:seshat/models/note.dart';
import 'package:seshat/utils/icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:seshat/widgets/selectionText.dart';

class NotePage extends StatefulWidget {
  const NotePage(
      {super.key,
      required this.width,
      required this.height,
      required this.note});
  final double width;
  final double height;
  final Note note;

  @override
  State<NotePage> createState() => _UpdateNotePage();
}

class _UpdateNotePage extends State<NotePage> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  final String _defaultTitle = "Untitled";
  var _id = null;
  bool _deleted = false;

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _textController.text = widget.note.text;
    _titleController.text = widget.note.title;
    setState(() {
      _id = widget.note.id;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (_deleted) return;

    switch (state) {
      case AppLifecycleState.inactive:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateNote();
        });
        break;

      default:
        break;
    }
  }

  Future<void> _deleteNote() async {
    try {
      await deleteNote(_id);
      Fluttertoast.showToast(
          msg: "Deleting note...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      setState(() {
        _deleted = true;
      });
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Failed on delete Note",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: const Color.fromARGB(255, 244, 67, 54),
          fontSize: 16.0);
    }
  }

  Future<void> _updateNote() async {
    String title = _titleController.text;
    String text = _textController.text;

    if (title == widget.note.title && text == widget.note.text) return;

    if (title.isEmpty) {
      title = _defaultTitle;
    }

    try {
      await updateNote(Note(
          title: title,
          text: text,
          id: _id,
          createdDate: widget.note.createdDate));
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Failed on update Note",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

  Future<void> _shareNote() async {
    final text = _textController.text;
    final title = _titleController.text;

    await Share.share(text, subject: title);
  }

  @override
  Widget build(BuildContext context) {
    final double height = widget.height;
    final double width = widget.width;
    const double topBarSize = 120;
    final double bodySize = height - topBarSize;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
        onPopInvoked: (didPop) async => {await _updateNote()},
        child: SelectionText(
            child: Scaffold(
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
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    icon: back(),
                                  ),
                                  Container(
                                      child: Row(children: [
                                    IconButton(
                                        onPressed: _shareNote, icon: share()),
                                    IconButton(
                                      onPressed: () => {
                                        _deleteNote().then(
                                            (result) => Navigator.pop(context))
                                      },
                                      icon: trash(),
                                    )
                                  ]))
                                ]),
                          ),
                          SizedBox(
                            width: width,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: TextField(
                                maxLength: 20,
                                controller: _titleController,
                                keyboardType: TextInputType.text,
                                onTapOutside: (event) =>
                                    {FocusScope.of(context).unfocus()},
                                cursorColor:
                                    Theme.of(context).colorScheme.secondary,
                                textAlign: TextAlign.center,
                                showCursor: true,
                                style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    hintText: _defaultTitle,
                                    contentPadding: const EdgeInsets.all(0),
                                    hintMaxLines: 1,
                                    border: InputBorder.none,
                                    counterText: '',
                                    hintStyle: const TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: bodySize -
                        (keyboardHeight != 0 ? keyboardHeight - 10 : 0),
                    width: width,
                    padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: TextField(
                          expands: true,
                          controller: _textController,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.start,
                          maxLines: null,
                          maxLength: 20000,
                          onTapOutside: (event) =>
                              {FocusScope.of(context).unfocus()},
                          showCursor: true,
                          style: const TextStyle(
                              fontSize: 24, fontFamily: 'Roboto'),
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
        )));
  }
}
