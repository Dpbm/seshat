class Note {
  final int? id;
  final String? preview;
  final String title;
  final String text;

  const Note({this.id, this.preview, required this.title, required this.text});

  Map<String, Object?> toMap() {
    String textFix = text.replaceAll("\n", " ");
    return {
      'id': id,
      'title': title,
      'preview': textFix.length < 40 ? textFix : (textFix.substring(0, 40) + '...'),
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
