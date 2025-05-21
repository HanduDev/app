import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/data/repositories/auth/auth_repository_remote.dart';
import '../__mocks__/general_mocks.mocks.dart'; 

void main() {
  late MockGoogleAuthImpl googleAuth;
  late MockHttpServiceImpl http;
  late MockSecureStorageImpl storage;
  late AuthRepositoryRemote repository;

  setUp(() {
    googleAuth = MockGoogleAuthImpl();
    http = MockHttpServiceImpl();
    storage = MockSecureStorageImpl();

    repository = AuthRepositoryRemote(
      googleAuth: googleAuth,
      httpService: http,
      secureStorage: storage,
    );
  });

  group('AuthRepositoryRemote', () {
    test('signInWithGoogle deve retornar um User e salvar token', () async {
      final mockGoogleUser = MockGoogleSignInAccount();
      final mockAuth = MockGoogleSignInAuthentication();

      when(googleAuth.signIn()).thenAnswer((_) async => mockGoogleUser);
      when(mockGoogleUser.authentication).thenAnswer((_) async => mockAuth);
      when(mockAuth.idToken).thenReturn('fake-id-token');

      when(http.post('/authentication/google', any)).thenAnswer(
        (_) async => {
          'id': 1,
          'fullName': 'Usuário Teste',
          'email': 'teste@email.com',
          'token': 'abc123',
          'isEmailConfirmed': true,
          'photoURL': null,
        },
      );

      final user = await repository.signInWithGoogle();

      expect(user.fullName, 'Usuário Teste');
      verify(storage.write('token', 'abc123')).called(1);
    });

    test('signIn deve retornar um User e salvar token', () async {
      when(http.post('/authentication/login', any)).thenAnswer(
        (_) async => {
          'id': 2,
          'fullName': 'Login User',
          'email': 'login@email.com',
          'token': 'login-token',
          'isEmailConfirmed': true,
          'photoURL': null,
        },
      );

      final user = await repository.signIn(
        email: 'login@email.com',
        password: '123456',
      );

      expect(user.email, 'login@email.com');
      verify(storage.write('token', 'login-token')).called(1);
    });

    test('signUp deve retornar um User e salvar token', () async {
      when(http.post('/authentication/register', argThat(isA<Map<String, dynamic>>()))).thenAnswer(
        (_) async => {
          'id': 3,
          'fullName': 'Novo Usuário',
          'email': 'novo@email.com',
          'token': 'token-novo',
          'isEmailConfirmed': true,
          'photoURL': null,
        },
      );

      final user = await repository.signUp(
        name: 'Novo Usuário',
        email: 'novo@email.com',
        password: 'senha123',
      );

      expect(user.fullName, 'Novo Usuário');
      verify(storage.write('token', 'token-novo')).called(1);
    });

    test('me deve retornar o usuário salvo se token existir', () async {
      when(storage.read('token')).thenAnswer((_) async => 'token-valido');

      when(http.get(any)).thenAnswer(
        (_) async => {
          'id': 4,
          'fullName': 'Usuário Atual',
          'email': 'atual@email.com',
          'isEmailConfirmed': true,
          'photoURL': null,
        },
      );

      final user = await repository.me();

      expect(user?.fullName, 'Usuário Atual');
    });

    test('me deve retornar null se não houver token', () async {
      when(storage.read('token')).thenAnswer((_) async => null);

      final user = await repository.me();

      expect(user, null);
    });

    test('signOut deve limpar token e desconectar Google', () async {
      await repository.signOut();

      verify(googleAuth.signOut()).called(1);
      verify(storage.delete('token')).called(1);
    });

    test('verifyCode deve retornar usuário após verificação', () async {
      when(http.post('/users/confirm_email', any)).thenAnswer(
        (_) async => {
          'id': 5,
          'fullName': 'Verificado',
          'email': 'verificado@email.com',
          'isEmailConfirmed': true,
          'photoURL': null,
        },
      );

      final user = await repository.verifyCode(code: '123456');

      expect(user.fullName, 'Verificado');
    });

    test('resendCode deve fazer POST sem erros', () async {
      when(http.post('/users/resend_email_confirmation', any)).thenAnswer((_) async => {});

      await repository.resendCode(code: '123');

      verify(http.post('/users/resend_email_confirmation', {})).called(1);
    });
  });
}
