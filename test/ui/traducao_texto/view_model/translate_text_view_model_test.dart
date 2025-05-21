import 'package:app/models/language.dart';
import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_text_request.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../__mocks__/general_mocks.mocks.dart'; 

void main() {
  late MockTranslateRepositoryImpl mockTranslateRepository;
  late MockDropdownButtonController mockFromLanguageController;
  late MockDropdownButtonController mockToLanguageController;
  late TranslateTextViewModel translateTextViewModel;

  setUp(() {
    mockTranslateRepository = MockTranslateRepositoryImpl();
    mockFromLanguageController = MockDropdownButtonController();
    mockToLanguageController = MockDropdownButtonController();

    translateTextViewModel =
        TranslateTextViewModel(translateRepository: mockTranslateRepository)
          ..fromlanguageController = mockFromLanguageController
          ..tolanguageController = mockToLanguageController;
  });

  group('TranslateTextViewModel', () {
    test(
      'Deve chamar translateRepository e retornar a tradução corretamente',
      () async {
        final languagePt = Language(name: 'Português', code: 'pt');
        final languageEn = Language(name: 'Inglês', code: 'en');

        when(mockFromLanguageController.value).thenReturn(languagePt);
        when(mockToLanguageController.value).thenReturn(languageEn);
        
        when(
          mockTranslateRepository.create(any),
        ).thenAnswer((_) async => Translate(message: 'Hello'));

        final result = await translateTextViewModel.translateText('Olá');

        expect(result, 'Hello');

        verify(
          mockTranslateRepository.create(
            argThat(
              predicate<TranslateTextRequest>(
                (request) =>
                    request.text == 'Olá' &&
                    request.fromLanguage == 'pt' &&
                    request.toLanguage == 'en',
              ),
            ),
          ),
        ).called(1);
      },
    );

    test('Deve retornar erro se a tradução falhar', () async {
      final languagePt = Language(name: 'Português', code: 'pt');
      final languageEn = Language(name: 'Inglês', code: 'en');

      when(mockFromLanguageController.value).thenReturn(languagePt);
      when(mockToLanguageController.value).thenReturn(languageEn);

      when(
        mockTranslateRepository.create(
          argThat(
            isA<TranslateTextRequest>()
                .having((r) => r.text, 'text', 'Meu nome é Everton')
                .having((r) => r.fromLanguage, 'fromLanguage', 'pt')
                .having((r) => r.toLanguage, 'toLanguage', 'en'),
          ),
        ),
      ).thenThrow(Exception('Erro na tradução'));

      final result = await translateTextViewModel.translateText(
        'Meu nome é Everton',
      );

      expect(result, 'Error: Exception: Erro na tradução');
      verify(
        mockTranslateRepository.create(
          argThat(
            isA<TranslateTextRequest>()
                .having((r) => r.text, 'text', 'Meu nome é Everton')
                .having((r) => r.fromLanguage, 'fromLanguage', 'pt')
                .having((r) => r.toLanguage, 'toLanguage', 'en'),
          ),
        ),
      ).called(1);
    });

    test('Deve trocar os idiomas corretamente', () {
      final languagePt = Language(name: 'Português', code: 'pt');
      final languageEn = Language(name: 'Inglês', code: 'en');

      when(mockFromLanguageController.value).thenReturn(languagePt);
      when(mockToLanguageController.value).thenReturn(languageEn);

      translateTextViewModel.swapLanguages();

      verify(mockFromLanguageController.value = languageEn).called(1);
      verify(mockToLanguageController.value = languagePt).called(1);
    });
  });
}
