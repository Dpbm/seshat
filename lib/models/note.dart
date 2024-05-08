class Note {
  final int? id;
  final String? preview;
  final String title;
  final String text;

  const Note({this.id, this.preview, required this.title, required this.text});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'preview': text.length < 20 ? text : (text.substring(20) + '...'),
      'text': text,
      'date': DateTime.now().toString(),
      'search': title + ' ' + text
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, text: $text, preview: $preview}';
  }
}
