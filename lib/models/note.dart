class Note {
  final int? id;
  final String preview;
  final String text;
  final String date;

  const Note(
      {this.id, required this.preview, required this.text, required this.date});

  Map<String, Object?> toMap() {
    return {'id': id, 'preview': preview, 'text': text, 'date': date};
  }

  @override
  String toString() {
    return 'Note{id: $id, preview: $preview, text: $text, date: $date}';
  }
}
