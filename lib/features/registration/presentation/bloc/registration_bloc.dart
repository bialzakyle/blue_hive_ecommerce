import 'package:bluehive_ecommerce_test/features/registration/presentation/bloc/registration_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Cubit<RegistrationState> {
  RegistrationBloc() : super(RegistrationInitialState());

  void register({required String email, required String password}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential value) => emit(RegisterSuccessState()))
        .onError((Object? error, StackTrace stackTrace) =>
            emit(RegisterFailedState(error: error.toString())));
  }
}
