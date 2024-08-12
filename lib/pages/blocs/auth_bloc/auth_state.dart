part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class Registersuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}
