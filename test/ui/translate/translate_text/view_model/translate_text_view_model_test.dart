import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/models/language.dart';
import 'package:app/models/translate/translate.dart';
import 'package:app/models/translate/translate_text_request.dart';
import 'package:app/ui/translate/translate_text/view_model/translate_text_view_model.dart';
import '../../../../__mocks__/general_mocks.mocks.dart';

void main() {
  late MockTranslateRepositoryImpl mockTranslateRepository;
  late DropdownButtonController<Language> fromLanguageController;
  late DropdownButtonController<Language> toLanguageController;
  late TranslateTextViewModel translateTextViewModel;

  setUp(() {
    mockTranslateRepository = MockTranslateRepositoryImpl();

    fromLanguageController = DropdownButtonController<Language>(
      initialValue: Language(name: 'Português', code: 'pt'),
    );

    toLanguageController = DropdownButtonController<Language>(
      initialValue: Language(name: 'Inglês', code: 'en'),
    );

    translateTextViewModel =
        TranslateTextViewModel(translateRepository: mockTranslateRepository)
          ..fromlanguageController = fromLanguageController
          ..tolanguageController = toLanguageController;
  });

  group('TranslateTextViewModel', () {
    test(
      'Deve chamar translateRepository e retornar a tradução corretamente',
      () async {
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

    test('Deve trocar os idiomas corretamente', () {
      expect(fromLanguageController.value?.code, 'pt');
      expect(toLanguageController.value?.code, 'en');

      translateTextViewModel.swapLanguages();

      expect(fromLanguageController.value?.code, 'en');
      expect(toLanguageController.value?.code, 'pt');
    });
  });

  test('Deve retornar erro se a tradução falhar', () async {
    fromLanguageController.value = Language(name: 'Português', code: 'pt');
    toLanguageController.value = Language(name: 'Inglês', code: 'en');

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
}
