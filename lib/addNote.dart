import 'package:flutter/material.dart';
import 'package:seshat/utils/icons.dart';

class AddNote extends StatelessWidget {
  const AddNote(
      {super.key,
      required this.width,
      required this.height,
      required this.topBarSize,
      required this.bodySize});

  final double width;
  final double height;
  final double topBarSize;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
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
                    margin: const EdgeInsets.fromLTRB(26, 10, 26, 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () => {Navigator.pop(context)},
                            icon: back(),
                          ),

                          /*const Text(
                        "Your Notes",
                        style: TextStyle(fontSize: 32, fontFamily: 'Roboto'),
                      ),*/
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
                  alignment: Alignment.topLeft,
                  child: TextField(
                    autocorrect: true,
                    autofocus: true,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
