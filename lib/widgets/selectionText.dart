import 'package:flutter/material.dart';

class SelectionText extends StatelessWidget {
  final Widget child;

  const SelectionText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: Theme.of(context).colorScheme.secondary,
                selectionColor: const Color(0xFFFFFFFF),
                selectionHandleColor: Theme.of(context).colorScheme.secondary)),
        child: child);
  }
}
