import 'package:flutter/material.dart';
import 'package:seshat/db/db.dart';
import 'package:seshat/utils/icons.dart';
import 'package:seshat/add_note.dart';
import 'package:seshat/widgets/note.dart';
import 'package:seshat/search.dart';
import 'package:seshat/note_page.dart';
import 'package:seshat/models/note.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  State<Home> createState() => _HomePage();
}

class _HomePage extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  int _totalNotes = 0;
  int _loadNotes = 10;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTotalNotes();
    });
    _scrollController.addListener(_updateNotesLimit);
  }

  Future<void> _updateTotalNotes() async {
    int totalNotes = await getTotalNotes();
    setState(() {
      _totalNotes = totalNotes;
    });
  }

  void _updateNotesLimit() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        _loadNotes < _totalNotes) {
      setState(() {
        _loadNotes += 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double height = widget.height;
    const double topBarSize = 70;
    final double bodySize = height - topBarSize;

    Future<void> goToNote(Note noteData) async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NotePage(width: width, height: height, note: noteData)));
      setState(() {});
    }

    Future<void> addNote() async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNote(
                    width: width,
                    height: height,
                  )));
      setState(() {});
    }

    Widget cardsList(context, snapshot) {
      var data = snapshot.data;
      final bool noData = !snapshot.hasData ||
          data == null ||
          data.toString().compareTo("[]") == 0;

      if (snapshot.hasError) {
        return Container(
            height: bodySize,
            alignment: Alignment.center,
            child: Text("Failed on get your notes!!!",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    color: Theme.of(context).colorScheme.error)));
      }

      if (noData) {
        return Container(
            height: bodySize,
            alignment: Alignment.center,
            child: Text("You don't have any notes yet!",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    color: Theme.of(context).colorScheme.shadow)));
      }

      List<Widget> childrenLeftColumn = [];
      List<Widget> childrenRightColumn = [];
      int i = 0;
      for (final Note noteData in data) {
        Widget card = GestureDetector(
          onTap: () => goToNote(noteData),
          child: note(noteData),
        );

        if (i % 2 == 0) {
          childrenLeftColumn.add(card);
        } else {
          childrenRightColumn.add(card);
        }
        i++;
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: childrenLeftColumn,
          ),
          Column(children: childrenRightColumn)
        ],
      );
    }

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
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Your Notes",
                            style:
                                TextStyle(fontSize: 32, fontFamily: 'Roboto'),
                          ),
                          IconButton(
                              onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Search(
                                                width: width,
                                                height: height,
                                              )),
                                    )
                                  },
                              icon: search())
                        ],
                      ),
                    ))),
            Container(
                color: Theme.of(context).colorScheme.primary,
                height: bodySize,
                width: width,
                padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: FutureBuilder(
                      future: getNotes(_loadNotes), builder: cardsList),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        tooltip: 'Create Note',
        //mini: false,
        shape: CircleBorder(
          side: BorderSide(
              width: 10, color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: plus(),
      ),
    );
  }
}
