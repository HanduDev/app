class Option {
  final int id;
  final String content;
  final bool isCorrect;

  Option({required this.id, required this.content, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    final id = json['id'] is String ? int.parse(json['id']) : json['id'];

    return Option(
      id: id,
      content: json['content'],
      isCorrect: json['isCorrect'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'content': content};
  }
}
