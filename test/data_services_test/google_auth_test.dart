import 'package:app/data/services/google_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late GoogleAuth googleAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockGoogleSignInAccount;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    googleAuth = GoogleAuth();
  });

  group('GoogleAuth', () {
    test(
      'Deve retornar um GoogleSignInAccount quando o login for bem-sucedido',
      () async {
        when(mockGoogleSignInAccount.displayName).thenReturn('Test User');
        when(mockGoogleSignInAccount.email).thenReturn('testuser@example.com');

        when(
          mockGoogleSignIn.signIn(),
        ).thenAnswer((_) async => mockGoogleSignInAccount);

        final result = await googleAuth.signIn();

        expect(result, isNotNull);
        expect(result!.displayName, 'Test User');
        expect(result.email, 'testuser@example.com');
      },
    );

    test('Deve retornar null se o login falhar', () async {
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      final result = await googleAuth.signIn();

      expect(result, isNull);
    });
  });
}
