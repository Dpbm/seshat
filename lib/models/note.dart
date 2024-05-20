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

    List<String> previewLines = [];

    if (textLines.isNotEmpty) {
      for (String line in textLines) {
        if (previewLines.length >= maxLines) break;

        String lineCut = line;
        while (lineCut.length > lengthPerLine) {
          previewLines.add(lineCut.substring(0, lengthPerLine.toInt()));
          lineCut = lineCut.substring(lengthPerLine.toInt(), lineCut.length);
        }
        lineCut += '\n';
        previewLines.add(lineCut);
      }

      if (previewLines.length > maxLines) {
        preview = previewLines.sublist(0, maxLines).join('');
        preview += '...';
      } else {
        preview = previewLines.join('');
      }

      if (textLines.length > maxLines || text.length > maxChar) {
        preview += '...';
      }
    } else {
      if (text.length > maxChar) {
        preview = text.substring(0, maxChar);
        preview += '...';
      } else {
        preview = text;
      }
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
