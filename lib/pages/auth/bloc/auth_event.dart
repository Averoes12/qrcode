part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthEventLogin extends AuthEvent {
  final String email;
  final String pass;

  AuthEventLogin(this.email, this.pass);
}
final class AuthEventLogout extends AuthEvent {}

