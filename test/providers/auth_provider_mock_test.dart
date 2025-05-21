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

  group('AuthProvider with Generated Mock', () {
    test(
      'init should set isLoading to false and user to null if me returns null',
      () async {
        when(mockAuthRepository.me()).thenAnswer((_) async => null);

        await authProvider.init();
        expect(authProvider.user, null);
        verify(mockAuthRepository.me()).called(1);
      },
    );

    test(
      'init should set isLoading to false and user if me returns a user',
      () async {
        final testUser = User(
          id: 5,
          fullName: 'Existing User',
          email: 'existing@example.com',
          isEmailConfirmed: true,
        );
        when(mockAuthRepository.me()).thenAnswer((_) async => testUser);

        await authProvider.init();
        expect(authProvider.user, testUser);
        verify(mockAuthRepository.me()).called(1);
      },
    );

    test('signInWithGoogle should update user and loading state', () async {
      when(mockAuthRepository.signInWithGoogle()).thenAnswer(
        (_) async => User(
          id: 1,
          fullName: 'Google User',
          email: 'google@example.com',
          isEmailConfirmed: true,
          photoURL: 'https://example.com/google_photo.jpg',
        ),
      );

      expect(authProvider.isGoogleLoading, false);
      await authProvider.signInWithGoogle();
      expect(authProvider.isGoogleLoading, false);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 1);
      expect(authProvider.user?.fullName, 'Google User');
      expect(authProvider.user?.email, 'google@example.com');
      expect(authProvider.user?.isEmailConfirmed, true);
      expect(
        authProvider.user?.photoURL,
        'https://example.com/google_photo.jpg',
      );
      verify(mockAuthRepository.signInWithGoogle()).called(1);
    });

    test(
      'signOut should set user to null and call signOut on repository',
      () async {
        when(mockAuthRepository.signInWithGoogle()).thenAnswer(
          (_) async => User(
            id: 6,
            fullName: 'Some User',
            email: 'some@example.com',
            isEmailConfirmed: false,
          ),
        );
        await authProvider.signInWithGoogle();

        when(mockAuthRepository.signOut()).thenAnswer((_) async {});
        await authProvider.signOut();
        expect(authProvider.user, null);
        verify(mockAuthRepository.signOut()).called(1);
      },
    );

    test('signIn should update user and authenticating state', () async {
      when(
        mockAuthRepository.signIn(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer(
        (_) async => User(
          id: 2,
          fullName: 'Test User',
          email: 'test@example.com',
          isEmailConfirmed: false,
        ),
      );

      expect(authProvider.isAuthenticating, false);
      await authProvider.signIn(
        email: 'test@example.com',
        password: 'password',
      );
      expect(authProvider.isAuthenticating, false);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 2);
      expect(authProvider.user?.email, 'test@example.com');
      expect(authProvider.user?.fullName, 'Test User');
      expect(authProvider.user?.isEmailConfirmed, false);
      verify(
        mockAuthRepository.signIn(
          email: 'test@example.com',
          password: 'password',
        ),
      ).called(1);
    });

    test('signUp should update user and authenticating state', () async {
      when(
        mockAuthRepository.signUp(
          name: anyNamed('name'),
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer(
        (_) async => User(
          id: 3,
          fullName: 'New User',
          email: 'new@example.com',
          isEmailConfirmed: false,
        ),
      );

      expect(authProvider.isAuthenticating, false);
      await authProvider.signUp(
        name: 'New User',
        email: 'new@example.com',
        password: 'password',
      );
      expect(authProvider.isAuthenticating, false);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 3);
      expect(authProvider.user?.fullName, 'New User');
      expect(authProvider.user?.email, 'new@example.com');
      expect(authProvider.user?.isEmailConfirmed, false);
      verify(
        mockAuthRepository.signUp(
          name: 'New User',
          email: 'new@example.com',
          password: 'password',
        ),
      ).called(1);
    });

    test('verifyCode should update user and authenticating state', () async {
      when(mockAuthRepository.verifyCode(code: anyNamed('code'))).thenAnswer(
        (_) async => User(
          id: 4,
          fullName: 'Verified User',
          email: 'verify@example.com',
          isEmailConfirmed: true,
        ),
      );

      expect(authProvider.isAuthenticating, false);
      await authProvider.verifyCode(code: '123456');
      expect(authProvider.isAuthenticating, false);
      expect(authProvider.user, isNotNull);
      expect(authProvider.user?.id, 4);
      expect(authProvider.user?.fullName, 'Verified User');
      expect(authProvider.user?.email, 'verify@example.com');
      expect(authProvider.user?.isEmailConfirmed, true);
      verify(mockAuthRepository.verifyCode(code: '123456')).called(1);
    });

    test(
      'resendCode should call resendCode on repository and update authenticating state',
      () async {
        when(
          mockAuthRepository.resendCode(code: anyNamed('code')),
        ).thenAnswer((_) async {});

        expect(authProvider.isAuthenticating, false);
        await authProvider.resendCode(code: '123456');
        expect(authProvider.isAuthenticating, false);
        verify(mockAuthRepository.resendCode(code: '123456')).called(1);
      },
    );
  });
}
