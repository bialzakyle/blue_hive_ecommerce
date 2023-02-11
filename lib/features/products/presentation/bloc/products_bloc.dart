import 'package:bluehive_ecommerce_test/features/products/presentation/bloc/products_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Cubit<ProductsState> {
  ProductsBloc() : super(ProductsInitialState());

  void logOut() async {
    emit(LogOutLoadingState());
    await FirebaseAuth.instance
        .signOut()
        .then((void value) => emit(LogOutSuccessState()))
        .onError((Object? error, StackTrace stackTrace) =>
            emit(LogOutFailedState(error: error.toString())));
  }

  void addToCart(
      {required int id, required String name, required double price}) async {
    emit(AddToCartLoadingState());
    Map<String, dynamic> cartMap = <String, dynamic>{};
    cartMap["id"] = id;
    cartMap["name"] = name;
    cartMap["price"] = price;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc()
        .set(cartMap)
        .then((void value) => emit(AddToCartSuccessState()))
        .onError((Object? error, StackTrace stackTrace) =>
            emit(AddToCartFailedState(error: error.toString())));
  }
}
