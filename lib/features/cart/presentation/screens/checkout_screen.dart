import 'package:bluehive_ecommerce_test/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});
  static const String routeName = '/checkoutScreen';
  static const String screenName = 'CheckoutScreen';
  static ModalRoute<void> route() => MaterialPageRoute<void>(
      builder: (_) => CheckOutScreen(),
      settings: RouteSettings(name: routeName));

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.appLightBlue, shape: BoxShape.circle),
                  height: screenSize.height * 0.2,
                  child: Center(
                      child: Icon(Icons.check,
                          size: screenSize.height * 0.15,
                          color: AppColors.appWhite))),
              SizedBox(height: 40),
              Text('Thank you!',
                  style: TextStyle(
                      color: AppColors.appTextBlue,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(
                  'Your order will be delivered to \nyour doorstep within 1 - 2 weeks.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.appTextGrey, fontSize: 14)),
            ],
          ),
          bottomSheet: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                      width: double.infinity,
                      height: screenSize.height / 15,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.appTextBlue)),
                          onPressed: () {
                            Navigator.of(context).popUntil(
                                (Route<dynamic> route) => route.isFirst);
                          },
                          child: Container(
                              height: 52,
                              width: MediaQuery.of(context).size.width * .2,
                              alignment: Alignment.center,
                              child: Text('OKAY',
                                  style: TextStyle(
                                      color: AppColors.appWhite,
                                      fontSize:
                                          screenSize.height * 0.018)))))))),
    );
  }
}
