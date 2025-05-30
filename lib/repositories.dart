import 'package:app/data/repositories/auth/auth_repository.dart';
import 'package:app/data/repositories/auth/auth_repository_remote.dart';
import 'package:app/data/repositories/language/language_repository.dart';
import 'package:app/data/repositories/language/language_repository_remote.dart';
import 'package:app/data/repositories/lesson/lesson_repository.dart';
import 'package:app/data/repositories/lesson/lesson_repository_remote.dart';
import 'package:app/data/repositories/lesson/check_answer/check_answer_repository.dart';
import 'package:app/data/repositories/lesson/check_answer/check_answer_repository_remote.dart';
import 'package:app/data/repositories/trail/trail_repository.dart';
import 'package:app/data/repositories/trail/trail_repository_remote.dart';
import 'package:app/data/repositories/translate/translate_repository.dart';
import 'package:app/data/repositories/translate/translate_repository_remote.dart';
import 'package:app/data/services/google_auth.dart';
import 'package:app/data/services/http.dart';
import 'package:app/data/services/secure_storage.dart';
import 'package:provider/provider.dart';

class Repositories {
  static List<Provider> providers() {
    return [
      Provider<AuthRepositoryImpl>(
        create:
            (context) => AuthRepositoryRemote(
              googleAuth: GoogleAuth(),
              httpService: context.read<HttpServiceImpl>(),
              secureStorage: context.read<SecureStorageImpl>(),
            ),
      ),
      Provider<LanguageRepositoryImpl>(
        create:
            (context) => LanguageRepositoryRemote(
              httpService: context.read<HttpServiceImpl>(),
            ),
      ),
      Provider<TrailRepositoryImpl>(
        create:
            (context) => TrailRepositoryRemote(
              httpService: context.read<HttpServiceImpl>(),
            ),
      ),
      Provider<TranslateRepositoryImpl>(
        create:
            (context) => TranslateRepositoryRemote(
              httpService: context.read<HttpServiceImpl>(),
            ),
      ),
      Provider<TranslateRepositoryImageImpl>(
        create:
            (context) => TranslateRepositoryRemote(
              httpService: context.read<HttpServiceImpl>(),
            ),
      ),
      Provider<LessonRepositoryImpl>(
        create:
            (context) => LessonRepositoryRemote(
              httpService: context.read<HttpServiceImpl>(),
            ),
      ),
      Provider<CheckAnswerRepositoryImpl>(
        create:
            (context) => CheckAnswerRepositoryRemote(
              httpService: context.read<HttpServiceImpl>(),
            ),
      ),
    ];
  }
}
