import 'package:bluehive_ecommerce_test/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RegistrationFields extends StatefulWidget {
  const RegistrationFields(
      {super.key,
      required this.hintText,
      required this.icon,
      this.textInputAction,
      required this.controller,
      required this.isPassword});
  final String hintText;
  final Icon icon;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final bool isPassword;

  @override
  State<RegistrationFields> createState() => _RegistrationFieldsState();
}

class _RegistrationFieldsState extends State<RegistrationFields> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
        width: screenSize.width * 0.9,
        child: TextFormField(
          obscureText: widget.isPassword ? true : false,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          style: TextStyle(
              fontSize: screenSize.height * 0.019, color: AppColors.appBlack),
          decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.appRed),
                  borderRadius: BorderRadius.circular(40)),
              labelText: widget.hintText,
              isDense: true,
              hintStyle: TextStyle(color: AppColors.appGrey),
              hintText: widget.hintText,
              prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenSize.height * 0.017,
                      screenSize.height * 0.016,
                      screenSize.height * 0.016,
                      screenSize.height * 0.016),
                  child: widget.icon),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(40)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(40))),
        ));
  }
}
