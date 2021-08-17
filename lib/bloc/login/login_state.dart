part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {} // estado inicial

class LoginLoading extends LoginState {} //loading cargando

class LoggedInBlocState extends LoginState {
  // logueado valido
  final String token;
  LoggedInBlocState(this.token);

  @override
  List<Object> get props => [token];
}

class ErrorBlocState extends LoginState {
  // error
  final String message;
  ErrorBlocState(this.message);

  @override
  List<Object> get props => [message];
}
