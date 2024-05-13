import 'package:path/path.dart';
import 'package:seshat/models/note.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDB() async {
  final database = openDatabase(join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
    db.execute(
      'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, preview TEXT, text TEXT, date TEXT, search TEXT)',
    );
  }, version: 1);

  return database;
}

Future<void> insertNote(Note note) async {
  final db = await getDB();
  db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
}

Future<List<Note>> searchNotes(String term) async {
  final db = await getDB();

  final List<Map<String, Object?>> notes =
      await db.query('notes', where: "search LIKE ?", whereArgs: ['%$term%']);

  return [
    for (final {
          'id': id as int,
          'title': title as String,
          'preview': preview as String,
          'text': text as String,
        } in notes)
      Note(id: id, preview: preview, text: text, title: title),
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
          'title': title as String,
          'preview': preview as String,
          'text': text as String,
        } in notes)
      Note(id: id, preview: preview, title: title, text: text),
  ];
}

Future<void> updateNote(Note note) async {
  final db = await getDB();
  // TODO: get the error on screen
  db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
}

Future<int> getTotalNotes() async {
  final db = await getDB();
  var rows = await db.rawQuery('SELECT COUNT(id) FROM notes');
  return Sqflite.firstIntValue(rows) ?? 0;
}
