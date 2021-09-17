import 'package:sugar_meter/src/core/auth_repository/user_model.dart';

abstract class AuthRepositoryBase {
  AuthUser get currentUser;

  Future<void> signOut();

  Stream<AuthUser> authStateChanges();

  Future<AuthUser> signInAnonymously();

  Future<AuthUser> signInWithFacebook();

  Future<AuthUser> signInWithGoogle();

  Future<AuthUser> signInWithEmailAndPassword(String email, String password);

  Future<AuthUser> createUserWithEmailAndPassword(
      String email, String password);
}
