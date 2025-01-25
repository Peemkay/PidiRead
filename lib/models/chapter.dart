class Chapter {
  final String title;
  final String filePath;

  Chapter({required this.title, required this.filePath});

  Map<String, dynamic> toJson() => {'title': title, 'filePath': filePath};

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    title: json['title'],
    filePath: json['filePath'],
  );
}