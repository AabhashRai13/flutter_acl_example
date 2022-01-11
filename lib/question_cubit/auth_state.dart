part of 'auth_cubit.dart';

class AuthState {
  final String? email;

  const AuthState({required this.email});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));

  @override
  String toString() => 'AuthState(counterValue: $email,)';
}
