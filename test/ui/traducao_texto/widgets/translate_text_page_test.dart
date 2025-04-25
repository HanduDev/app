import 'package:app/data/repositories/language/language_repository.dart';
import 'package:app/models/language.dart';
import 'package:app/models/user.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/ui/core/shared/chat_field.dart';
import 'package:app/ui/core/shared/dropdown/dropdown_button_controller.dart';
import 'package:app/ui/traducao_texto/view_model/translate_text_view_model.dart';
import 'package:app/ui/traducao_texto/widgets/translate_text_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'translate_text_page_test.mocks.dart';

@GenerateMocks([
  AuthProvider,
  TranslateTextViewModel,
  FlutterTts,
  LanguagesProvider,
  LanguageRepositoryImpl,
])
void main() {
  late MockAuthProvider mockAuthProvider;
  late MockTranslateTextViewModel mockTranslateTextViewModel;
  late MockFlutterTts mockFlutterTts;
  late MockLanguagesProvider mockLanguagesProvider;
  late MockLanguageRepositoryImpl mockLanguageRepositoryImpl;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockTranslateTextViewModel = MockTranslateTextViewModel();
    mockFlutterTts = MockFlutterTts();
    mockLanguagesProvider = MockLanguagesProvider();
    mockLanguageRepositoryImpl = MockLanguageRepositoryImpl();

    when(mockLanguageRepositoryImpl.getAllLanguages()).thenAnswer(
      (_) async => [
        Language(code: 'pt', name: 'Português'),
        Language(code: 'en', name: 'Inglês'),
      ],
    );

    when(mockLanguagesProvider.languages).thenReturn([
      Language(code: 'pt', name: 'Português'),
      Language(code: 'en', name: 'Inglês'),
    ]);
  });

  group('TranslateTextPage', () {
    testWidgets('Deve renderizar a página corretamente', (
      WidgetTester tester,
    ) async {
      when(mockAuthProvider.user).thenReturn(
        User(
          id: 1,
          email: 'john@example.com',
          fullName: 'John Doe',
          isEmailConfirmed: true,
        ),
      );

      when(
        mockTranslateTextViewModel.fromlanguageController,
      ).thenReturn(DropdownButtonController());
      when(
        mockTranslateTextViewModel.tolanguageController,
      ).thenReturn(DropdownButtonController());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>.value(
                value: mockAuthProvider,
              ),
              ChangeNotifierProvider<TranslateTextViewModel>.value(
                value: mockTranslateTextViewModel,
              ),
              ChangeNotifierProvider<LanguagesProvider>(
                create: (_) => mockLanguagesProvider,
              ),
            ],
            child: TranslateTextPage(),
          ),
        ),
      );

      expect(find.text('John'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('Deve traduzir texto ao enviar mensagem', (
      WidgetTester tester,
    ) async {
      when(mockAuthProvider.user).thenReturn(
        User(
          id: 1,
          email: 'john@example.com',
          fullName: 'John Doe',
          isEmailConfirmed: true,
        ),
      );

      when(
        mockTranslateTextViewModel.fromlanguageController,
      ).thenReturn(DropdownButtonController());
      when(
        mockTranslateTextViewModel.tolanguageController,
      ).thenReturn(DropdownButtonController());

      when(
        mockTranslateTextViewModel.translateText('Olá'),
      ).thenAnswer((_) async => 'Hello');

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>.value(
                value: mockAuthProvider,
              ),
              ChangeNotifierProvider<TranslateTextViewModel>.value(
                value: mockTranslateTextViewModel,
              ),
              ChangeNotifierProvider<LanguagesProvider>(
                create: (_) => mockLanguagesProvider,
              ),
            ],
            child: TranslateTextPage(),
          ),
        ),
      );

      await tester.enterText(find.byType(ChatField).first, 'Olá');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('Deve falar o texto ao pressionar o botão', (
      WidgetTester tester,
    ) async {
      when(mockAuthProvider.user).thenReturn(
        User(
          id: 1,
          email: 'john@example.com',
          fullName: 'John Doe',
          isEmailConfirmed: true,
        ),
      );

      when(
        mockTranslateTextViewModel.fromlanguageController,
      ).thenReturn(DropdownButtonController());
      when(
        mockTranslateTextViewModel.tolanguageController,
      ).thenReturn(DropdownButtonController());

      when(
        mockTranslateTextViewModel.translateText('Olá'),
      ).thenAnswer((_) async => 'Hello');

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>.value(
                value: mockAuthProvider,
              ),
              ChangeNotifierProvider<TranslateTextViewModel>.value(
                value: mockTranslateTextViewModel,
              ),
              ChangeNotifierProvider<LanguagesProvider>(
                create: (_) => mockLanguagesProvider,
              ),
            ],
            child: TranslateTextPage(),
          ),
        ),
      );

      await tester.enterText(find.byType(ChatField).first, 'Olá');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.volume_up_outlined));
      await tester.pump();

      verify(mockFlutterTts.speak('Hello')).called(1);
    });

    testWidgets('Deve exibir feedback quando pressionado o botão de feedback', (
      WidgetTester tester,
    ) async {
      when(mockAuthProvider.user).thenReturn(
        User(
          id: 1,
          email: 'john@example.com',
          fullName: 'John Doe',
          isEmailConfirmed: true,
        ),
      );

      when(
        mockTranslateTextViewModel.fromlanguageController,
      ).thenReturn(DropdownButtonController());
      when(
        mockTranslateTextViewModel.tolanguageController,
      ).thenReturn(DropdownButtonController());

      when(
        mockTranslateTextViewModel.translateText('Olá'),
      ).thenAnswer((_) async => 'Hello');

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>.value(
                value: mockAuthProvider,
              ),
              ChangeNotifierProvider<TranslateTextViewModel>.value(
                value: mockTranslateTextViewModel,
              ),
              ChangeNotifierProvider<LanguagesProvider>(
                create: (_) => mockLanguagesProvider,
              ),
            ],
            child: TranslateTextPage(),
          ),
        ),
      );

      await tester.enterText(find.byType(ChatField).first, 'Olá');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.feedback_outlined));
      await tester.pump();

      expect(find.text('O que achou da tradução?'), findsOneWidget);
    });
  });
}
