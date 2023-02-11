import 'package:bluehive_ecommerce_test/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bluehive_ecommerce_test/features/login/presentation/bloc/login_bloc.dart';
import 'package:bluehive_ecommerce_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:bluehive_ecommerce_test/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Providers {
  Providers._internal();

  factory Providers() {
    return _instance;
  }

  Providers instance() {
    return _instance;
  }

  static final Providers _instance = Providers._internal();

  List<BlocProvider<dynamic>> getBlocProviders() {
    return <BlocProvider<dynamic>>[
      BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
      BlocProvider<RegistrationBloc>(
          create: (BuildContext context) => RegistrationBloc()),
      BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc()),
      BlocProvider<CartBloc>(create: (BuildContext context) => CartBloc())
    ];
  }
}
