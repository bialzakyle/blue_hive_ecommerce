import 'package:bluehive_ecommerce_test/app/app.dart';
import 'package:bluehive_ecommerce_test/app/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Providers providers = Providers().instance();
  List<BlocProvider<dynamic>> blocProviders = providers.getBlocProviders();
  runApp(MultiBlocProvider(providers: blocProviders, child: App()));
}
