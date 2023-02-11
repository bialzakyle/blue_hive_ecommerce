import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {}

class CartInitialState extends CartState {
  @override
  List<Object> get props => <Object>[];
}

class RemoveLoadingState extends CartState {
  @override
  List<Object> get props => <Object>[];
}

class RemoveSuccessState extends CartState {
  RemoveSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class RemoveFailedState extends CartState {
  RemoveFailedState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[];
}

class CheckOutLoadingState extends CartState {
  @override
  List<Object> get props => <Object>[];
}

class CheckOutSuccessState extends CartState {
  CheckOutSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class CheckOutFailedState extends CartState {
  CheckOutFailedState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[];
}

