import 'package:flutter/widgets.dart';
import 'package:seshat/db/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:seshat/models/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final testInsert1 = Note(
      preview: 'aaaaa...',
      text: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      date: DateTime.now().toString());

  final testInsert2 = Note(
      preview: 'bbbbb...',
      text: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
      date: DateTime.now().toString());

  print('insert....');
  await insertNote(testInsert1);
  await insertNote(testInsert2);

  print('search by "a"');
  print(await searchNotes('a'));

  print('get all....');
  print(await getNotes(10000));

  print('delete the first one');
  await deleteNote(1);

  print('get all again!');
  print(await getNotes(1000));

  final noteUpdates = Note(
      id: 2,
      preview: 'cccccc...',
      text: 'ccccccccccccccccccccccccc',
      date: DateTime.now().toString());

  print('update note!');
  await updateNote(noteUpdates);
  print(await getNotes(1000));
}
