import 'package:flutter/material.dart';
import 'package:seshat/models/note.dart';
import 'package:seshat/note_page.dart';

Widget note(Note data, BuildContext context, double width, double height) {
  return GestureDetector(
      onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotePage(width: width, height: height, note: data)))
          },
      child: Container(
          width: 150,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFFFFFF)),
          child: Column(
            children: [
              Text(data.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold)),
              Text(data.preview ?? '',
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 20, fontFamily: 'Roboto')),
            ],
          )));
}
