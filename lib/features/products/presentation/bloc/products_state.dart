import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {}

class ProductsInitialState extends ProductsState {
  @override
  List<Object> get props => <Object>[];
}

class AddToCartLoadingState extends ProductsState {
  @override
  List<Object> get props => <Object>[];
}

class AddToCartSuccessState extends ProductsState {
  AddToCartSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class AddToCartFailedState extends ProductsState {
  AddToCartFailedState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[];
}

class LogOutLoadingState extends ProductsState {
  @override
  List<Object> get props => <Object>[];
}

class LogOutSuccessState extends ProductsState {
  LogOutSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class LogOutFailedState extends ProductsState {
  LogOutFailedState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[];
}