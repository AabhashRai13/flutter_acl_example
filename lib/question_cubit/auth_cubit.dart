import 'dart:convert';

import 'package:acl_demo/core/injector.dart';
import 'package:acl_demo/core/shared_preference_manager.dart';
import 'package:acl_demo/services/auth_exception.dart';
import 'package:bloc/bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final String? userMail;
  AuthCubit({this.userMail}) : super(const AuthState(email: ""));

  AuthResultStatus? _authStatus;

  final SharedPreferencesManager sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  Future<String> get claims async {
    final user = sharedPreferencesManager.getString("email");
    emit(AuthState(email: user));
    String? claims;
    if (user == "aabhash@gmail.com") {
      claims = "member";
    } else if (user == "asutosh@gmail.com") {
      claims = "admin";
    }
    return (claims!);
  }

  AuthResultStatus signInWithEmailAndPassword({
    String? email,
    String? password,
  }) {
    sharedPreferencesManager.putString(SharedPreferencesManager.email, email!);

    emit(AuthState(email: email));
    if (sharedPreferencesManager.getString("email") != null) {
      _authStatus = AuthResultStatus.successful;
    } else {
      _authStatus = AuthResultStatus.undefined;
    }

    return _authStatus!;
  }

  signOut() {
    sharedPreferencesManager.clearAll();
    emit(const AuthState(email: ""));
  }
}
