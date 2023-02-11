import 'package:bluehive_ecommerce_test/app/constants/app_colors.dart';
import 'package:bluehive_ecommerce_test/features/cart/presentation/screens/cart_screen.dart';
import 'package:bluehive_ecommerce_test/features/login/presentation/screens/login_screen.dart';
import 'package:bluehive_ecommerce_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:bluehive_ecommerce_test/features/products/presentation/bloc/products_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  static const String routeName = '/productsScreen';
  static const String screenName = 'ProductsScreen';
  static ModalRoute<void> route() => MaterialPageRoute<void>(
      builder: (_) => ProductsScreen(),
      settings: RouteSettings(name: routeName));

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late ProductsBloc productsBloc;
  @override
  void initState() {
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          backgroundColor: AppColors.appLightBlue,
          actions: <Widget>[
            BlocListener<ProductsBloc, ProductsState>(
                listener: (BuildContext context, ProductsState state) {
              if (state is AddToCartSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added to cart'),
                ));
              }
              if (state is AddToCartFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Add to cart failed. Try again'),
                ));
              }
              if (state is LogOutSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Signed out'),
                ));
                Navigator.of(context).pushReplacement(LoginScreen.route());
              }
              if (state is LogOutFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to sign out'),
                ));
              }
            }, child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (BuildContext context, ProductsState state) {
              if (state is LogOutLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return IconButton(
                  onPressed: () {
                    productsBloc.logOut();
                  },
                  icon: Icon(Icons.logout));
            }))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Welcome, ${FirebaseAuth.instance.currentUser!.email!}',
                      style: TextStyle(
                          color: AppColors.appLightBlue,
                          fontSize: screenSize.height * 0.02))),
              SizedBox(height: screenSize.height * 0.03),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: fireStore.collection('products').snapshots(),
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
                              trailing:
                                  BlocBuilder<ProductsBloc, ProductsState>(
                                      builder: (BuildContext context,
                                          ProductsState state) {
                                if (state is AddToCartLoadingState) {
                                  return CircularProgressIndicator();
                                }
                                return InkWell(
                                    onTap: () {
                                      productsBloc.addToCart(
                                          id: doc.get('id'),
                                          name: doc.get('name'),
                                          price: doc.get('price'));
                                    },
                                    child: Text('Add to Cart'));
                              }),
                            ),
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
                    Navigator.of(context).push(CartScreen.route());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appLightBlue,
                      fixedSize: Size(
                          screenSize.width * 0.29, screenSize.height * 0.055)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 7),
                      Text('CART')
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
