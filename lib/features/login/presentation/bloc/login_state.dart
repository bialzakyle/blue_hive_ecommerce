import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => <Object>[];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => <Object>[];
}

class LoginSuccessState extends LoginState {
  LoginSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class LoginFailedState extends LoginState {
  LoginFailedState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[];
}