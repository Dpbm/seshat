import 'package:flutter/material.dart';
import 'package:seshat/utils/icons.dart';
import 'package:seshat/widgets/note.dart';
import 'package:seshat/models/note.dart';
import 'package:seshat/db/db.dart';
import 'package:seshat/note_page.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<Search> createState() => _SearchPage();
}

class _SearchPage extends State<Search> {
  final FocusNode _focusSearch = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  List<Note> _notes = [];
  String _order = 'desc';
  bool _getNotesError = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchNotes);
  }

  @override
  void dispose() {
    super.dispose();
    _focusSearch.dispose();
    _searchController.removeListener(_searchNotes);
    _searchController.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
  }

  Future<void> _searchNotes() async {
    final String term = _searchController.text;
    try {
      List<Note> notes = await searchNotes(term, _order);
      setState(() {
        _notes = notes;
        _getNotesError = false;
      });
    } catch (error) {
      setState(() {
        _getNotesError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topBarSize = 120 + (32 /*icons size*/) + 12;
    final double width = widget.width;
    final double height = widget.height;
    final double bodySize = height - topBarSize;

    Future<void> goToNote(Note noteData) async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NotePage(width: width, height: height, note: noteData)));
      setState(() {});
      await _searchNotes();
    }

    Widget cardsList() {
      if (_getNotesError) {
        return Container(
            height: bodySize,
            alignment: Alignment.center,
            child: Text("Failed on get your notes!!!",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    color: Theme.of(context).colorScheme.error)));
      }

      if (_notes.isEmpty) {
        return Container(
            height: bodySize,
            alignment: Alignment.center,
            child: Text("Haven't found any notes!!!",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    color: Theme.of(context).colorScheme.shadow)));
      }

      List<Widget> childrenLeftColumn = [];
      List<Widget> childrenRightColumn = [];
      int i = 0;
      for (final Note noteData in _notes) {
        Widget card = GestureDetector(
          onTap: () => goToNote(noteData),
          child:
              NoteCard(note: noteData, cardWidth: (width - (36 * 2)) / 2 - 10),
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

    return Theme(
        data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: Theme.of(context).colorScheme.shadow,
                selectionColor: Theme.of(context).colorScheme.shadow,
                selectionHandleColor: const Color(0xFFFFFFFF))),
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
                            Container(
                                alignment: Alignment.bottomLeft,
                                child: IconButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  icon: back(),
                                )),
                            Container(
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius:
                                      const BorderRadiusDirectional.all(
                                          Radius.circular(10))),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {}, icon: searchPrefix()),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      child: TextField(
                                          focusNode: _focusSearch,
                                          controller: _searchController,
                                          keyboardType: TextInputType.text,
                                          autofocus: true,
                                          textAlign: TextAlign.left,
                                          showCursor: true,
                                          autocorrect: false,
                                          enableSuggestions: false,
                                          onTapOutside: (event) =>
                                              {_focusSearch.unfocus()},
                                          cursorColor: const Color(0xFFFFFFFF),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Roboto',
                                              color: Color(0xFFFFFFFF),
                                              decoration: TextDecoration.none,
                                              decorationThickness: 0),
                                          decoration: InputDecoration(
                                              hintText: 'Type your search...',
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0,
                                                      0,
                                                      _focusSearch.hasFocus
                                                          ? 0
                                                          : 10,
                                                      0),
                                              hintMaxLines: 1,
                                              border: InputBorder.none,
                                              counterText: '',
                                              hintStyle: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Roboto',
                                                  color: Color.fromARGB(
                                                      135, 255, 255, 255))))),
                                  _focusSearch.hasFocus
                                      ? IconButton(
                                          onPressed: _clearSearch, icon: x())
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                            Container(
                                width: width,
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  value: _order,
                                  icon: filter(),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  items: const [
                                    DropdownMenuItem<String>(
                                        value: 'asc',
                                        child: Text('First Modified')),
                                    DropdownMenuItem<String>(
                                        value: 'desc',
                                        child: Text('Last Modified')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _order = value ?? _order;
                                    });
                                    _searchNotes();
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.primary,
                      height: bodySize,
                      width: width,
                      padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                      child: SingleChildScrollView(
                        child: cardsList(),
                      ),
                    ),
                  ],
                ))));
  }
}
