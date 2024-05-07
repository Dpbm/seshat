import 'package:path/path.dart';
import 'package:seshat/models/note.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDB() async {
  final database = openDatabase(join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
    db.execute(
      'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, preview TEXT, text TEXT, date TEXT)',
    );
  }, version: 1);

  return database;
}

Future<void> insertNote(Note note) async {
  final db = await getDB();
  // TODO: get the error on screen
  db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
}

Future<List<Note>> searchNotes(String term) async {
  final db = await getDB();

  final List<Map<String, Object?>> notes =
      await db.query('notes', where: "text LIKE ?", whereArgs: ['%$term%']);

  return [
    for (final {
          'id': id as int,
          'preview': preview as String,
          'text': text as String,
          'date': date as String
        } in notes)
      Note(id: id, preview: preview, text: text, date: date),
  ];
}

Future<void> deleteNote(int id) async {
  final db = await getDB();
  await db.delete('notes', where: 'id = ?', whereArgs: [id]);
}

Future<List<Note>> getNotes(int limit) async {
  final db = await getDB();

  final List<Map<String, Object?>> notes =
      await db.query('notes', limit: limit);

  return [
    for (final {
          'id': id as int,
          'preview': preview as String,
          'text': text as String,
          'date': date as String
        } in notes)
      Note(id: id, preview: preview, text: text, date: date),
  ];
}

Future<void> updateNote(Note note) async {
  final db = await getDB();
  // TODO: get the error on screen
  db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
}
