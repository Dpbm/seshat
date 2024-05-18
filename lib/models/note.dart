import 'dart:ffi';

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

      for (String line in textLines) {
        if (lineCounter >= maxLines) break;

        if (line.length > lengthPerLine) {
          lineCounter += ((line.length / lengthPerLine).toInt() + 1);
        } else {
          lineCounter++;
        }

        preview += line;
        preview += '\n';
      }

      if (preview.length > maxChar) {
        preview = preview.substring(0, maxChar);
        preview += '...';
      } else if (textLines.length > maxLines || preview.length < text.length) {
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
