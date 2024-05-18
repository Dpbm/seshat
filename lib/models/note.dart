class Note {
  final int? id;
  final String? preview;
  final String title;
  final String text;

  const Note({this.id, this.preview, required this.title, required this.text});

  Map<String, Object?> toMap() {
    const int maxChar = 40;
    const int maxLines = 4;
    const double lengthPerLine = maxChar / maxLines;

    List<String> textLines = text.split("\n");
    String preview = '';

    if (textLines.isNotEmpty) {
      int lineCounter = 0;
      int totalExceded = 0;

      for (String line in textLines) {
        if (lineCounter >= maxLines) break;
        preview += line;
        preview += '\n';
        lineCounter++;

        if (line.length > lengthPerLine) {
          totalExceded += line.length - lengthPerLine.toInt();
        }
      }

      if (totalExceded > 0) {
        preview = preview.substring(0, preview.length - totalExceded);
        preview += '...';
      } else if (textLines.length > 4) {
        preview += '...';
      }
    } else {
      preview =
          text.length >= maxChar ? text.substring(0, maxChar) + '...' : text;
    }

    return {
      'id': id,
      'title': title,
      'preview': preview,
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
