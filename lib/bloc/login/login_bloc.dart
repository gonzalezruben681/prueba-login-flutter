import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_flutter/repositories/auth_repository.dart';

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
        yield ErrorBlocState(ex.toString());
      }
    }
  }
}
