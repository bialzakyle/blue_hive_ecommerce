import 'package:bluehive_ecommerce_test/features/login/presentation/bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitialState());

  void login({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential value) => emit(LoginSuccessState()))
        .onError((Object? error, StackTrace stackTrace) =>
            emit(LoginFailedState(error: error.toString())));
  }
}
