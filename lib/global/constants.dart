import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Constants {

  //colors
  static const Color background = Color(0XFFFFFFFF);
  static const Color borderLightGrey = Color(0xFFC8C8C8);
  static const Color hintGrey = Color(0xFF6A6A6A);
  static const Color hintColor = Color(0xff7d7d7d);


  //status bar style
  static statusBar(Color color, Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: color,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
    ));
  }

  //button style
  static buttonStyle({isDisable=false}){
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isDisable? Colors.green.withOpacity(0.6): Colors.green ),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),)
    );
  }

  static borderButtonStyle({isDisable=false}){
    return ButtonStyle(
      side: MaterialStateProperty.all( BorderSide(width: 1.0, color: isDisable? Colors.green.withOpacity(0.6): Colors.green)),
      backgroundColor: MaterialStateProperty.all(Colors.white ),
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(Colors.transparent),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),),);
  }

  //show toast
  static showToast(String message) {
    EasyLoading.showToast(message, toastPosition: EasyLoadingToastPosition.top);
  }

  static Future<DateTime> selectPastDate(BuildContext context, {DateTime? givenDate, DateTime? firstDate}) async {
    DateTime selectedDate = givenDate ?? DateTime.now();
    DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget ?child) {
          return Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? const Text(""),
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: givenDate == null ? DateTime(2300) :givenDate.add(const Duration(days: 100)) );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    return selectedDate;
  }

  static Future<TimeOfDay> selectTime(BuildContext context, TimeOfDay selectedTime) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );});

    if (picked_s != null && picked_s != selectedTime ){

      print("time==>$picked_s");

      return picked_s;
    }

    return TimeOfDay.now();
  }

  //input decoration
  static inputDecoration({String hint=""}){
    return  InputDecoration(
      counterText: "",
      contentPadding: const EdgeInsets.symmetric(vertical: 13),
      hintText: hint,
      hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
      border: InputBorder.none,
    );
  }

  static bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

}
