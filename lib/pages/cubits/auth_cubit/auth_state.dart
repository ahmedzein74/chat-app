part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class Registersuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}

class LoginSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}
