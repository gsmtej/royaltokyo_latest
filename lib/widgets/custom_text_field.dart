import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget 
{
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;
  String? Function(String?)? validator;


CustomTextField
({
  this.controller,
  this.data,
  this.hintText,
  this.isObsecre,
  this.enabled,
  this.validator,

});

  @override
  Widget build(BuildContext context) {
     return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          obscureText: isObsecre!,
          cursorColor: Theme.of(context).primaryColor,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              data,
              color: Colors.cyan,
            ),
            fillColor: Colors.white,
            filled: true,
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
class CustomphoneField extends StatelessWidget
{
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;
  String? Function(String?)? validator;

  CustomphoneField
      ({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecre,
    this.enabled,
    this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        keyboardType: TextInputType.phone,
        cursorColor: Theme.of(context).primaryColor,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly
        ],
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
          fillColor: Colors.white,
          filled: true,
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}