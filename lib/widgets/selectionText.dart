import 'package:flutter/material.dart';

Widget selectionText(Widget child, BuildContext context) {
  return Theme(
      data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Theme.of(context).colorScheme.secondary,
              selectionColor: const Color(0xFFFFFFFF),
              selectionHandleColor: Theme.of(context).colorScheme.secondary)),
      child: child);
}
