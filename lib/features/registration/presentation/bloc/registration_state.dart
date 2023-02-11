import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {}

class RegistrationInitialState extends RegistrationState {
  @override
  List<Object> get props => <Object>[];
}

class RegisterLoadingState extends RegistrationState {
  @override
  List<Object> get props => <Object>[];
}

class RegisterSuccessState extends RegistrationState {
  RegisterSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class RegisterFailedState extends RegistrationState {
  RegisterFailedState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[];
}