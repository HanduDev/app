import 'package:app/data/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({required this.secureStorage});

  final SecureStorageImpl secureStorage;

  Locale _locale = const Locale('pt', 'BR');
  bool _isLoading = false;

  final List<Locale> _supportedLocales = [
    const Locale('pt', 'BR'),
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
  ];

  Locale get locale => _locale;
  List<Locale> get supportedLocales => _supportedLocales;
  bool get isLoading => _isLoading;

  Future<void> setLocale(Locale locale) async {
    _isLoading = true;
    notifyListeners();

    await LocalJsonLocalization.delegate.load(locale);

    _locale = locale;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> initialize() async {
    final locale = await secureStorage.read('locale');

    if (locale != null) {
      final split = locale.split('-');

      await setLocale(Locale(split[0], split[1]));
    }
  }
}
