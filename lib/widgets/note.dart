import 'package:flutter/material.dart';
import 'package:seshat/models/note.dart';

Widget note(Note data) {
  return GestureDetector(
      onTap: () => {/**TODO: pass the data to the edit screen */},
      child: Container(
          width: 150,
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
