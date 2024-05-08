import 'package:flutter/widgets.dart';
import 'package:seshat/db/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:seshat/models/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final testInsert1 =
      Note(title: 'ee', text: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

  final testInsert2 =
      Note(title: 'ee', text: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');

  print('insert....');
  await insertNote(testInsert1);
  await insertNote(testInsert2);

  print('search by "a"');
  print(await searchNotes('a'));
  print('search by title "e"');
  print(await searchNotes('e'));

  print('get all....');
  print(await getNotes(10000));

  print('delete the first one');
  await deleteNote(1);

  print('get all again!');
  print(await getNotes(1000));

  final noteUpdates =
      Note(id: 2, title: 'ee', text: 'ccccccccccccccccccccccccc');

  print('update note!');
  await updateNote(noteUpdates);
  print(await getNotes(1000));
}
