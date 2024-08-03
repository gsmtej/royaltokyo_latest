import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class AppUtils {

  static Widget commonErrorMessage({String? message}) {
    return Center(
      child: Text(
        message!,
        style: TextStyle(
        fontSize: 12,
          color: Colors.black,
          fontFamily: "Poppins",
        // fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  static BoxDecoration containerDecoration({
    double radius = 13,
    Color color = Colors.white,
    double? borderWidth,
    Color colorBorder = AppColor.colorWhiteLight,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(color: colorBorder, width: borderWidth ?? 2), /*    */
    );
  }
  static showMessage(
      {BuildContext? context, String? message, Color? backgroundColor}) {
    return ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        content: Text(
          textAlign: TextAlign.left,
          message ?? "",
          style: TextStyle(
               fontSize: 16,
              color:  AppColor.colorWhite,
              fontWeight: FontWeight.w500,
            ),
        ),
        backgroundColor: backgroundColor ?? AppColor.colorLogout,
      ),
    );
  }

  static Widget showLoaderList() {
    return Center(
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: AppUtils.containerDecoration(
            radius: 50,
            borderWidth: 0,
            colorBorder: Colors.transparent,
            color: AppColor.colorWhite.withOpacity(0.70),
          ),
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 1.0,
          )),
    );
  }

  static Widget showLoader(bool isLoading) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: Container(
          //    padding: EdgeInsets.all(AppConstants.twenty),
          /* decoration: AppUtils.containerDecoration(
              radius: AppConstants.ten,
              color: AppColor.colorBlue.withOpacity(0.90),
            ),*/
            child: CircularProgressIndicator(
              color: AppColor.colorWhite,
              strokeWidth: 2.0,
            )),
      ),
    );
  }

}


class AppColor{

  static const Color colorBlue=Color.fromRGBO(17, 31, 72, 1);
  static const Color colorBlueLight=Color.fromRGBO(0, 27, 105, 0.24);
  static const Color colorGrayLight= Color.fromRGBO(255, 255, 255, 0.08);
  static const Color colorGrayLight1= Color.fromRGBO(255, 255, 255, 0.3);
  static const Color colorWhite= Color.fromRGBO(255, 255, 255, 1);
  static const Color colorWhite1= Color.fromRGBO(255, 255, 255, 0.6);
  static const Color colorWhiteLight= Color.fromRGBO(255, 255, 255, 0.1);
  static const Color colorButton= Color.fromRGBO(106, 90, 230, 1);
  static const Color colorFb= Color.fromRGBO(24, 119, 242, 1);
  static const Color colorFbLight= Color.fromRGBO(100, 81, 238, 0.9);
  static const Color colorRedLight= Color.fromRGBO(215, 91, 74, 0.54);
  static const Color colorBlueLight1= Color.fromRGBO(86, 204, 255, 0.54);
  static const Color colorGreenLight= Color.fromRGBO(5, 84, 63, 0.54);
  static const Color colorOrange= Color.fromRGBO(255, 165, 0,1);
  static const Color colorCredit= Color.fromRGBO(1, 12, 47, 0.59);
  static const Color colorYellowLight= Color.fromRGBO(180, 111, 37, 0.54);
  static const Color colorWt= Color.fromRGBO(38, 59, 108, 0);
  static const Color colorLogout= Color.fromRGBO(235, 87, 87, 1);
  static const Color colorToolBar= Color.fromRGBO(40, 56, 110, 1);
  //static const Color colorButtonUpdate= Color.fromRGBO(106, 90, 230, 1);
  static const Color colorDarkBlue= Color.fromRGBO(0, 27, 105, 1);
  static const Color colorGreenDark= Color.fromRGBO(5, 185, 53, 1);
  static const Color colorBlueClub= Color.fromRGBO(38, 59, 108, 1);
  static const Color colorBottom= Color.fromRGBO(81, 91, 123, 1);
  static const Color colorAddPlayer= Color.fromRGBO(81, 98, 137, 1);
  static const Color colorDialog= Color.fromRGBO(21, 39, 98, 0.9);
  static const Color colorBlackLight= Color.fromRGBO(0, 0, 0, 0.32);
  static const Color colorEdit= Color.fromRGBO(144, 130, 255, 1);
  static const Color colorGreen= Color.fromRGBO(39, 174, 96, 1);
  static const Color colorDirection= Color.fromRGBO(27, 43, 83, 1);
  static const Color colorBorder= Color.fromRGBO(67, 84, 123, 1);
  static const Color colorTimePicker= Color.fromRGBO(111, 119, 149, 1);
  static const Color colorCommonDialog= Color.fromRGBO(8, 28, 91, 1);
  static const Color colorHint= Color.fromRGBO(116, 121, 128, 1);
  static const Color colorRemoveText= Color.fromRGBO(137, 126, 245, 1);
  static const Color colorFillEditText= Color.fromRGBO(82, 96, 140, 1);
  static const Color colorUnderList= Color.fromRGBO(50, 70, 116, 1);
  static const Color ColorDialogFill= Color.fromRGBO(8, 28, 91, 1);

  // static Color colorAppBar = _colorFromHex("#d14b92");
  static  Color colorTransparent = _colorFromHex("#X00FFFFFF");

  static Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse('FF' + hexColor, radix: 16));
  }


}