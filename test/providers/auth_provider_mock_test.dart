import 'package:app/models/user.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../__mocks__/general_mocks.mocks.dart';

void main() {
  late MockAuthRepositoryImpl mockAuthRepository;
  late AuthProvider authProvider;

  setUp(() {
    mockAuthRepository = MockAuthRepositoryImpl();
    authProvider = AuthProvider(authRepository: mockAuthRepository);
  });

  group('AuthProvider with real implementation and mocked repository', () {
    test('init sets user to null when repository returns null', () async {
      when(mockAuthRepository.me()).thenAnswer((_) async => null);

      await authProvider.init();

      expect(authProvider.user, isNull);
      verify(mockAuthRepository.me()).called(1);
    });

    test('init sets user when repository returns a User', () async {
      final user = User(
        id: 5,
        fullName: 'Existing User',
        email: 'existing@example.com',
        isEmailConfirmed: true,
      );
      when(mockAuthRepository.me()).thenAnswer((_) async => user);

      await authProvider.init();

      expect(authProvider.user, equals(user));
      verify(mockAuthRepository.me()).called(1);
    });

    test('signInWithGoogle updates user and loading state', () async {
      final googleUser = User(
        id: 1,
        fullName: 'Google User',
        email: 'google@example.com',
        isEmailConfirmed: true,
        photoURL: 'https://example.com/google_photo.jpg',
      );
      when(
        mockAuthRepository.signInWithGoogle(),
      ).thenAnswer((_) async => googleUser);

      expect(authProvider.isGoogleLoading, isFalse);
      await authProvider.signInWithGoogle();
      expect(authProvider.isGoogleLoading, isFalse);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 1);
      expect(authProvider.user?.fullName, 'Google User');
      expect(authProvider.user?.email, 'google@example.com');
      expect(authProvider.user?.isEmailConfirmed, isTrue);
      expect(authProvider.user?.photoURL, googleUser.photoURL);

      verify(mockAuthRepository.signInWithGoogle()).called(1);
    });

    test('signOut resets user and calls repository signOut', () async {
      final someUser = User(
        id: 6,
        fullName: 'Some User',
        email: 'some@example.com',
        isEmailConfirmed: false,
      );
      when(
        mockAuthRepository.signInWithGoogle(),
      ).thenAnswer((_) async => someUser);
      await authProvider.signInWithGoogle();

      when(mockAuthRepository.signOut()).thenAnswer((_) async {});

      await authProvider.signOut();

      expect(authProvider.user, isNull);
      verify(mockAuthRepository.signOut()).called(1);
    });

    test('signIn updates user and authenticating state', () async {
      final testUser = User(
        id: 2,
        fullName: 'Test User',
        email: 'test@example.com',
        isEmailConfirmed: false,
      );
      when(
        mockAuthRepository.signIn(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => testUser);

      expect(authProvider.isAuthenticating, isFalse);

      await authProvider.signIn(
        email: 'test@example.com',
        password: 'password',
      );

      expect(authProvider.isAuthenticating, isFalse);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 2);
      expect(authProvider.user?.email, 'test@example.com');
      expect(authProvider.user?.fullName, 'Test User');
      expect(authProvider.user?.isEmailConfirmed, isFalse);

      verify(
        mockAuthRepository.signIn(
          email: 'test@example.com',
          password: 'password',
        ),
      ).called(1);
    });

    test('signUp updates user and authenticating state', () async {
      final newUser = User(
        id: 3,
        fullName: 'New User',
        email: 'new@example.com',
        isEmailConfirmed: false,
      );
      when(
        mockAuthRepository.signUp(
          name: anyNamed('name'),
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => newUser);

      expect(authProvider.isAuthenticating, isFalse);

      await authProvider.signUp(
        name: 'New User',
        email: 'new@example.com',
        password: 'password',
      );

      expect(authProvider.isAuthenticating, isFalse);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 3);
      expect(authProvider.user?.fullName, 'New User');
      expect(authProvider.user?.email, 'new@example.com');
      expect(authProvider.user?.isEmailConfirmed, isFalse);

      verify(
        mockAuthRepository.signUp(
          name: 'New User',
          email: 'new@example.com',
          password: 'password',
        ),
      ).called(1);
    });

    test('verifyCode updates user and authenticating state', () async {
      final verifiedUser = User(
        id: 4,
        fullName: 'Verified User',
        email: 'verify@example.com',
        isEmailConfirmed: true,
      );
      when(
        mockAuthRepository.verifyCode(code: anyNamed('code'), email: 'teste@gmail.com'),
      ).thenAnswer((_) async => verifiedUser);

      expect(authProvider.isAuthenticating, isFalse);

      await authProvider.verifyCode(code: '123456', email: 'teste@gmail.com');

      expect(authProvider.isAuthenticating, isFalse);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 4);
      expect(authProvider.user?.fullName, 'Verified User');
      expect(authProvider.user?.email, 'verify@example.com');
      expect(authProvider.user?.isEmailConfirmed, isTrue);

      verify(mockAuthRepository.verifyCode(code: '123456', email: 'teste@gmail.com')).called(1);
    });

    test(
      'resendCode calls repository and updates authenticating state',
      () async {
        when(
          mockAuthRepository.resendCode(code: anyNamed('code'), email: 'teste@gmail.com'),
        ).thenAnswer((_) async {});

        expect(authProvider.isAuthenticating, isFalse);

        await authProvider.resendCode(code: '123456', email: 'teste@gmail.com');

        expect(authProvider.isAuthenticating, isFalse);
        verify(mockAuthRepository.resendCode(code: '123456', email: 'teste@gmail.com')).called(1);
      },
    );
  });
}
