import 'package:bluehive_ecommerce_test/app/constants/app_colors.dart';
import 'package:bluehive_ecommerce_test/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:bluehive_ecommerce_test/features/registration/presentation/bloc/registration_state.dart';
import 'package:bluehive_ecommerce_test/widgets/registration_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const String routeName = '/regScreen';
  static const String screenName = 'registrationScreen';
  static ModalRoute<void> route() => MaterialPageRoute<void>(
      builder: (_) => RegistrationScreen(),
      settings: RouteSettings(name: routeName));

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationBloc registrationBloc;
  final TextEditingController name = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController repeatPass = TextEditingController();

  @override
  void initState() {
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    contactNo.dispose();
    userName.dispose();
    email.dispose();
    password.dispose();
    repeatPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text('Register'), backgroundColor: AppColors.appLightBlue),
        body: SingleChildScrollView(
          child: SizedBox(
            width: screenSize.width * 1,
            height: screenSize.height * 0.9,
            child: Column(children: <Widget>[
              SizedBox(height: screenSize.height * 0.04),
              Center(
                child: Text('Please enter your information',
                    style: TextStyle(
                        color: AppColors.appLightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * 0.025)),
              ),
              Center(
                  child: Text(
                      'Make sure that all necessary information \n needed will be filled.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.appTextGrey,
                          fontSize: screenSize.height * 0.017))),
              SizedBox(height: screenSize.height * 0.05),
              RegistrationFields(
                  isPassword: false,
                  controller: name,
                  hintText: 'Name',
                  textInputAction: TextInputAction.next,
                  icon: Icon(Icons.person)),
              SizedBox(height: screenSize.height * 0.017),
              RegistrationFields(
                  isPassword: false,
                  controller: contactNo,
                  hintText: 'Contact No.',
                  textInputAction: TextInputAction.next,
                  icon: Icon(Icons.numbers)),
              SizedBox(height: screenSize.height * 0.017),
              RegistrationFields(
                  isPassword: false,
                  controller: userName,
                  hintText: 'Username',
                  textInputAction: TextInputAction.next,
                  icon: Icon(Icons.abc)),
              SizedBox(height: screenSize.height * 0.017),
              RegistrationFields(
                  isPassword: false,
                  controller: email,
                  hintText: 'E-mail Address',
                  textInputAction: TextInputAction.next,
                  icon: Icon(Icons.email)),
              SizedBox(height: screenSize.height * 0.017),
              RegistrationFields(
                  isPassword: true,
                  controller: password,
                  hintText: 'Password',
                  textInputAction: TextInputAction.next,
                  icon: Icon(Icons.password)),
              SizedBox(height: screenSize.height * 0.017),
              RegistrationFields(
                  isPassword: true,
                  controller: repeatPass,
                  hintText: 'Re-enter Password',
                  textInputAction: TextInputAction.done,
                  icon: Icon(Icons.password)),
              Spacer(),
              Container(
                height: screenSize.height * 0.09,
                width: screenSize.width * 0.96,
                padding: EdgeInsets.all(screenSize.height * 0.016),
                child: ElevatedButton(
                  onPressed: () {
                    if (name.text.isNotEmpty &&
                        contactNo.text.isNotEmpty &&
                        userName.text.isNotEmpty &&
                        email.text.isNotEmpty &&
                        password.text.isNotEmpty &&
                        repeatPass.text.isNotEmpty) {
                      if (password.text == repeatPass.text) {
                        registrationBloc.register(
                            email: email.text, password: password.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Passwords do not match'),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please fill up all the fields'),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBlue),
                  child: BlocListener<RegistrationBloc, RegistrationState>(
                      listener:
                          (BuildContext context, RegistrationState state) {
                    if (state is RegisterSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Successfully registered. Welcome!'),
                      ));
                      Navigator.of(context).pop();
                    }
                    if (state is RegisterFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Registration failed. Try Again.'),
                      ));
                    }
                  }, child: BlocBuilder<RegistrationBloc, RegistrationState>(
                          builder:
                              (BuildContext context, RegistrationState state) {
                    if (state is RegisterLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text('SUBMIT');
                  })),
                ),
              ),
              SizedBox(height: screenSize.height * 0.025)
            ]),
          ),
        ));
  }
}
