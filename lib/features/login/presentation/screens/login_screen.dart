import 'package:bluehive_ecommerce_test/app/constants/app_colors.dart';
import 'package:bluehive_ecommerce_test/features/products/presentation/screens/products_screen.dart';
import 'package:bluehive_ecommerce_test/features/login/presentation/bloc/login_bloc.dart';
import 'package:bluehive_ecommerce_test/features/login/presentation/bloc/login_state.dart';
import 'package:bluehive_ecommerce_test/features/registration/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/loginScreen';
  static const String screenName = 'LoginScreen';
  static ModalRoute<void> route() => MaterialPageRoute<void>(
      builder: (_) => LoginScreen(), settings: RouteSettings(name: routeName));

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool hideText = true;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenSize.height * .17),
                    Icon(Icons.storefront_sharp,
                        size: screenSize.height * 0.15,
                        color: AppColors.appLightBlue),
                    SizedBox(height: screenSize.height * .01),
                    Text('Welcome to \nBlue Hive eCommerce',
                        style: TextStyle(
                            color: AppColors.appLightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * .035),
                        textAlign: TextAlign.center),
                    SizedBox(height: screenSize.height * 0.08),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: screenSize.height * 0.07,
                        child: TextFormField(
                            controller: email,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                isDense: true,
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenSize.height * .018),
                                labelText: 'E-mail'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenSize.height * .018))),
                    SizedBox(height: screenSize.height * 0.02),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: screenSize.height * 0.07,
                        child: TextFormField(
                            obscureText: hideText,
                            controller: password,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        hideText = !hideText;
                                      });
                                    },
                                    child: Icon(
                                        hideText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: screenSize.height * 0.035,
                                        color: AppColors.appTextBlue)),
                                isDense: true,
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenSize.height * .018),
                                labelText: 'Password'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenSize.height * .018))),
                    SizedBox(height: screenSize.height * 0.01),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(RegistrationScreen.route());
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: Text('Register here',
                                style: TextStyle(
                                    color: AppColors.appLightBlue,
                                    fontSize: screenSize.height * 0.016)))),
                    SizedBox(height: screenSize.height * 0.06),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                            width: double.infinity,
                            height: screenSize.height / 15,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.appLightBlue)),
                                onPressed: () {
                                  if (email.text.isNotEmpty &&
                                      password.text.isNotEmpty) {
                                    loginBloc.login(
                                        email: email.text,
                                        password: password.text);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Please enter your username and password'),
                                    ));
                                  }
                                },
                                child: Container(
                                    height: 52,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    alignment: Alignment.center,
                                    child: BlocListener<LoginBloc, LoginState>(
                                      listener: (BuildContext context,
                                          LoginState state) {
                                        if (state is LoginSuccessState) {
                                          Navigator.of(context).pushReplacement(
                                              ProductsScreen.route());
                                        }
                                        if (state is LoginFailedState) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Login failed. Try Again.'),
                                          ));
                                        }
                                      },
                                      child: BlocBuilder<LoginBloc, LoginState>(
                                        builder: (BuildContext context,
                                            LoginState state) {
                                          if (state is LoginLoadingState) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          return Text('SIGN IN');
                                        },
                                      ),
                                    ))))),
                  ],
                ))));
  }
}
