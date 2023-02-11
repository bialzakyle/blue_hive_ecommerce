import 'package:bluehive_ecommerce_test/app/constants/app_colors.dart';
import 'package:bluehive_ecommerce_test/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bluehive_ecommerce_test/features/cart/presentation/bloc/cart_state.dart';
import 'package:bluehive_ecommerce_test/features/cart/presentation/screens/checkout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String routeName = '/cartScreen';
  static const String screenName = 'CartScreen';
  static ModalRoute<void> route() => MaterialPageRoute<void>(
      builder: (_) => CartScreen(), settings: RouteSettings(name: routeName));

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc cartBloc;
  bool cartEmpty = true;

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    checkCart();
    super.initState();
  }

  void checkCart() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get();
    if (snapshot.docs.isNotEmpty) {
      cartEmpty = false;
    }
  }

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text('Your Cart'), backgroundColor: AppColors.appLightBlue),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<CartBloc, CartState>(
            listener: (BuildContext context, CartState state) {
              if (state is RemoveSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Removed from cart'),
                ));
              }
              if (state is RemoveFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to remove'),
                ));
              }
              if (state is CheckOutSuccessState) {
                Navigator.of(context).push(CheckOutScreen.route());
              }
              if (state is CheckOutFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to check out'),
                ));
              }
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: fireStore
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((QueryDocumentSnapshot<Object?> doc) {
                            return Card(
                              child: ListTile(
                                  title: Text(doc.get('name')),
                                  subtitle: Text('₱${doc.get('price')}'),
                                  trailing: BlocBuilder<CartBloc, CartState>(
                                      builder: (BuildContext context,
                                          CartState state) {
                                    if (state is RemoveLoadingState) {
                                      return CircularProgressIndicator();
                                    }
                                    return IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        cartBloc.removeFromCart(
                                            documentReference: doc.reference);
                                      },
                                    );
                                  })),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        if (cartEmpty == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Your cart is empty'),
                          ));
                        } else {
                          cartBloc.checkOut();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appLightBlue,
                          fixedSize: Size(screenSize.width * 0.4,
                              screenSize.height * 0.055)),
                      child: BlocBuilder<CartBloc, CartState>(
                          builder: (BuildContext context, CartState state) {
                        if (state is CheckOutLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(Icons.payment),
                            SizedBox(width: 7),
                            Text('CHECK OUT')
                          ],
                        );
                      })),
                )
              ],
            ),
          ),
        ));
  }
}
