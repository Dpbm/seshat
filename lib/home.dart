import 'package:flutter/material.dart';
import 'package:seshat/utils/icons.dart';
import 'package:seshat/add_note.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    const double topBarSize = 70;
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
                              onPressed: () => {/*TODO add to search notes*/},
                              icon: search())
                        ],
                      ),
                    ))),
            Container(
                color: Theme.of(context).colorScheme.primary,
                height: bodySize,
                width: width,
                padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
                child: Align(
                  //Change this, to check if the user has any notes
                  alignment: Alignment.center,
                  child: Text("You don't have any notes yet!",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          color: Theme.of(context).colorScheme.shadow)),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNote(
                      width: width,
                      height: height,
                    )),
          )
        },
        tooltip: 'Create Note',
        mini: false,
        shape: CircleBorder(
          side: BorderSide(
              width: 80, color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: plus(),
      ),
    );
  }
}
