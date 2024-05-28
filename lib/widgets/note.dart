import 'package:flutter/material.dart';
import 'package:seshat/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final double cardWidth;

  const NoteCard({super.key, required this.note, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: cardWidth,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFFFFFF)),
        child: Column(
          children: [
            SizedBox(
                width: cardWidth,
                child: Text(note.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold))),
            SizedBox(
                width: cardWidth,
                child: Text(note.preview ?? '',
                    textAlign: TextAlign.left,
                    style:
                        const TextStyle(fontSize: 20, fontFamily: 'Roboto'))),
          ],
        ));
  }
}
