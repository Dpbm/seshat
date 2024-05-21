class Note {
  final int? id;
  final String? preview;
  final String title;
  final String text;
  final int? createdDate;

  const Note(
      {this.id,
      this.preview,
      required this.title,
      required this.text,
      this.createdDate});

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

      if (previewLines.length <= maxLines &&
          (textLines.length > maxLines || text.length > maxChar)) {
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

    print('COISANDNDNDNDNDNDN');
    print(createdDate);
    return {
      'id': id,
      'title': title,
      'preview': preview,
      'text': text,
      'createdDate': createdDate ?? DateTime.now().millisecondsSinceEpoch,
      'modifiedDate': DateTime.now().millisecondsSinceEpoch,
      'search': title + ' ' + text
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, text: $text, preview: $preview}';
  }
}
