part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class StartEvent extends LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  // al precionar el boton
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LoginOut extends LoginEvent {}
