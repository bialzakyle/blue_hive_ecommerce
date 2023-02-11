import 'package:bluehive_ecommerce_test/features/cart/presentation/bloc/cart_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartInitialState());

  void removeFromCart(
      {required DocumentReference<Object?> documentReference}) async {
    emit(RemoveLoadingState());
    await FirebaseFirestore.instance
        .runTransaction((Transaction transaction) async =>
            transaction.delete(documentReference))
        .then((void value) => emit(RemoveSuccessState()))
        .onError((Object? error, StackTrace stackTrace) =>
            emit(RemoveFailedState(error: error.toString())));
  }

  void checkOut() async {
    emit(CheckOutLoadingState());
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (DocumentSnapshot<Object?> ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    emit(CheckOutSuccessState());
  }
}
