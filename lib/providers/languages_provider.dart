import 'package:flutter/material.dart';

class LanguagesProvider extends ChangeNotifier {
  final List<Map<String, String>> _languages = [
    {'name': 'Libras', 'countryCode': 'pt-br'},
    {'name': 'Português', 'countryCode': 'pt-br'},
    {'name': 'Árabe', 'countryCode': 'ar'},
    {'name': 'Chinês', 'countryCode': 'zh-cn'},
    {'name': 'Coreano', 'countryCode': 'ko'},
    {'name': 'Espanhol', 'countryCode': 'es'},
    {'name': 'Francês', 'countryCode': 'fr'},
    {'name': 'Hindi', 'countryCode': 'hi'},
    {'name': 'Inglês', 'countryCode': 'en'},
    {'name': 'Italiano', 'countryCode': 'it'},
    {'name': 'Japonês', 'countryCode': 'ja'},
    {'name': 'Russo', 'countryCode': 'ru'},
    {'name': 'Turco', 'countryCode': 'tr'},
  ];

  List<Map<String, String>> get languages => List.unmodifiable(_languages);
}
