class FirstStepErrors {
  String? language;
  String? development;

  FirstStepErrors({this.language, this.development});

  set setLanguage(String? value) {
    language = value;
  }

  set setDevelopment(String? value) {
    development = value;
  }

  bool isValid() {
    return language == null && development == null;
  }
}
