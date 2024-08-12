part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class RegisterEvent extends AuthEvent {}
