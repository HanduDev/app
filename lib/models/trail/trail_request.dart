class TrailRequest {
  String language;
  List<String> developments;
  List<String> themes;
  String level;
  String timeToLearn;
  String timeToStudy;

  TrailRequest({
    required this.language,
    required this.developments,
    required this.themes,
    required this.level,
    required this.timeToLearn,
    required this.timeToStudy,
  });

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'developments': developments,
      'themes': themes,
      'level': level,
      'time_to_learn': timeToLearn,
      'time_to_study': timeToStudy,
    };
  }
}
