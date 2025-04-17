// auth_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'auth_provider_mock_test.mocks.dart';

void main() {
  late MockAuthProviderImpl mockAuthProvider;

  setUp(() {
    mockAuthProvider = MockAuthProviderImpl();
  });

  test('deve chamar signInWithGoogle', () async {
    when(mockAuthProvider.signInWithGoogle()).thenAnswer((_) async {});

    await mockAuthProvider.signInWithGoogle();

    verify(mockAuthProvider.signInWithGoogle()).called(1);
  });

  test('deve chamar signIn com email e senha', () async {
    const email = 'teste@email.com';
    const password = 'senha123';

    when(
      mockAuthProvider.signIn(email: email, password: password),
    ).thenAnswer((_) async {});

    await mockAuthProvider.signIn(email: email, password: password);

    verify(mockAuthProvider.signIn(email: email, password: password)).called(1);
  });
}
