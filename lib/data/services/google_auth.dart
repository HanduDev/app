import 'package:app/config/environment.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAuthImpl {
  Future<GoogleSignInAccount?> signIn();
}

class GoogleAuth extends GoogleAuthImpl {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: Environment.googleClientId,
  );

  @override
  Future<GoogleSignInAccount?> signIn() async {
    return await _googleSignIn.signIn();
  }
}
