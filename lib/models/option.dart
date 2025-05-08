class Option {
  final int id;
  final String content;

  Option({required this.id, required this.content});

  factory Option.fromJson(Map<String, dynamic> json) {
    final id = json['id'] is String ? int.parse(json['id']) : json['id'];

    return Option(id: id, content: json['content']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'content': content};
  }
}
