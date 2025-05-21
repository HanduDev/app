import 'package:app/data/repositories/auth/auth_repository.dart';
import 'package:app/data/repositories/language/language_repository.dart';
import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/data/services/google_auth.dart';
import 'package:app/data/services/http.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AuthRepositoryImpl,
  GoogleAuthImpl,
  SecureStorageImpl,
  HttpServiceImpl,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  AuthProvider,
  TranslateRepositoryImpl,
  DropdownButtonController,
  TranslateTextViewModel,
  FlutterTts,
  LanguagesProvider,
  LanguageRepositoryImpl,
])
void main() {}
