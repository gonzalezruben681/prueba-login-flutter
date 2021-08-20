import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_flutter/login/repositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      try {
        yield LoginLoading();
        final token = await authRepository.login(event.email, event.password);
        yield LoggedInBlocState(token!);
      } catch (ex) {
        yield ErrorBlocState("Error en el correo o contraseña");
      }
    }
    if (event is LoginOut) {
      yield LoginLoading();
      await authRepository.logout();
      yield LoggedOut();
    }
  }
}
