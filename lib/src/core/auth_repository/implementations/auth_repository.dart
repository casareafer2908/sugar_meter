import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sugar_meter/src/core/auth_repository/auth_repository_base.dart';
import 'package:sugar_meter/src/core/auth_repository/user_model.dart';

class AuthRepository implements AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthUser _userFromFirebase(User user) {
    return user == null ? null : AuthUser(user.uid, user.displayName);
  }

  @override
  AuthUser get currentUser => _userFromFirebase(_firebaseAuth.currentUser);

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<AuthUser> authStateChanges() => _firebaseAuth
      .authStateChanges()
      .asyncMap((User user) => _userFromFirebase(user));

  @override
  Future<AuthUser> signInAnonymously() async {
    final user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user.user);
  }

  @override
  Future<AuthUser> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final user = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );
        return _userFromFirebase(user.user);
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    var googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final user = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return _userFromFirebase(user.user);
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword(
      String email, String password) async {
    final user = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return _userFromFirebase(user.user);
  }

  @override
  Future<AuthUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(user.user);
  }
}
