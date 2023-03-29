class Note {
  final String title;
  final String content;
  final String? imagePath;

  Note({required this.title, required this.content, this.imagePath});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
