import 'package:flutter/material.dart';
import 'package:seshat/utils/icons.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusSearch.dispose();
    _searchController.dispose();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    const double topBarSize = 120;
    final double width = widget.width;
    final double height = widget.height;
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
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                              onPressed: () => {Navigator.pop(context)},
                              icon: back(),
                            )),
                        Container(
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: const BorderRadiusDirectional.all(
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
                                      onChanged: (value) => {},
                                      textAlign: TextAlign.left,
                                      showCursor: true,
                                      autocorrect: false,
                                      enableSuggestions: false,
                                      onTapOutside: (event) =>
                                          {FocusScope.of(context).unfocus()},
                                      cursorColor: const Color(0xFFFFFFFF),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Roboto',
                                          color: Color(0xFFFFFFFF),
                                          decoration: TextDecoration.none,
                                          decorationThickness: 0),
                                      decoration: InputDecoration(
                                          hintText: 'Type your search...',
                                          contentPadding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              _focusSearch.hasFocus ? 0 : 10,
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
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
