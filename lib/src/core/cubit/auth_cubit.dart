import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugar_meter/src/core/auth_repository/auth_repository_base.dart';
import 'package:sugar_meter/src/core/auth_repository/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryBase _authRepository;
  StreamSubscription _authSubscription;

  AuthCubit(this._authRepository) : super(AuthInitialState()) {
    _authSubscription =
        _authRepository.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(AuthUser user) =>
      user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));

  AuthUser getUser() => _authRepository.currentUser;

  Future<void> signInAnonymously() async {
    try {
      emit(AuthSigningIn());
      final user = await _authRepository.signInAnonymously();
      emit(AuthSignedIn(user));
    } on Exception catch (e) {
      emit(AuthError(
          "Error al intentar logear anonimamente, Error message: $e"));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthSigningIn());
      final user = await _authRepository.signInWithGoogle();
      emit(AuthSignedIn(user));
    } on Exception catch (e) {
      emit(AuthError("Can't Sign In, Error message: $e"));
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      emit(AuthSigningIn());
      final user = await _authRepository.signInWithFacebook();
      emit(AuthSignedIn(user));
    } on Exception catch (e) {
      emit(AuthError("Can't Sign In, Error message: $e"));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthSignedOut extends AuthState {}

class AuthSigningIn extends AuthState {}

class AuthSignedIn extends AuthState {
  final AuthUser user;

  AuthSignedIn(this.user);
}
