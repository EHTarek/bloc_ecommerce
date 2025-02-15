part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}
final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationLoginSuccess extends AuthenticationState {
  final LoginResponseEntity loginResponse;
  const AuthenticationLoginSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

final class AuthenticationLogoutSuccess extends AuthenticationState {}

final class AuthenticationRegistrationSuccess extends AuthenticationState {
  final SignUpResponseEntity signupResponse;
  const AuthenticationRegistrationSuccess(this.signupResponse);

  @override
  List<Object> get props => [signupResponse];
}

final class AuthenticationFailure extends AuthenticationState {
  final String message;
  const AuthenticationFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthenticationNoInternet extends AuthenticationState {}
final class AuthenticationSessionOut extends AuthenticationState {}
