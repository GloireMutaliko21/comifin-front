// ignore_for_file: constant_identifier_names, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const custom_blue = Color.fromARGB(255, 147, 179, 6);
const custom_green = Color.fromARGB(255, 6, 144, 202);
const custom_white = Color.fromARGB(255, 255, 255, 255);
const custom_red = Color.fromARGB(255, 243, 233, 233);
const custom_indigo = Color.fromARGB(255, 63, 81, 181);
const custom_black = Color.fromARGB(255, 7, 9, 17);
const custom_white12 = Color.fromARGB(255, 227, 222, 222);
const color_text = Color.fromARGB(255, 158, 155, 155);

const custom_orage = Color.fromARGB(255, 243, 132, 67);
const custom_orag1 = Color.fromARGB(255, 246, 218, 201);
const color_primary = Color(0xFFDD1313);
const color_primary_light = Color(0xFFFFECDF);
const color_primary_gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFFFA53E),
    Color(0xFFDD1313),
  ],
);
const animation_duration = Duration(milliseconds: 200);
const color_white = Color.fromARGB(255, 247, 244, 244);
const color_grey = Color.fromARGB(255, 245, 242, 242);
const color_darker_grey = Color(0xFFAAAAAA);
const color_black = Color(0xFF000000);
const color_red = Color(0xFFDD1313);
const color_green = Color.fromARGB(255, 18, 97, 61);
const color_orange = Color(0xFFFF9800);
const color_orange_sub = Color(0xFFFFE0B2);
const color_sub_title = Color(0xffa29aac);
const color_background = Color(0xfff2f2f2);
const color_background_2 = Color(0xFFEFEFEF);
const color_background_3 = Color(0xFFF3F2F3);
const color_txt_background = Color(0xFFF4F4F4);
const color_transparent = Color(0x00000000);
const color_lb_title = Color(0xff8e9396);
const color_blue = Color.fromARGB(255, 202, 238, 253);
const color_blue_light = Color(0xFFC7E5F0);
const color_phone_light = Color(0xff70A2D1);
const color_phone_dark = Color(0xff3576BE);
const color_google_light = Color(0xffDB7878);
const color_google_dark = Color(0xffCE3C3E);
const color_purple = Color(0xFF673AB7);

class AppFont {
  AppFont._();
  static const Color blueColor = Color(0xff015994);
  static const Color greyColor = Color(0xffF3F2F1);
  static String primaryFont = 'Poppins';
}

buildUIError(
  BuildContext context, {
  String? titleMessage,
  String? subTitleMessage,
  String? img,
  required VoidCallback onPressed,
}) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 25, left: 5, right: 5, bottom: 5),
      width: MediaQuery.of(context).size.width - 70,
      child: Material(
        shadowColor: Colors.grey.withOpacity(.2),
        elevation: 0,
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: SvgPicture.asset(img!),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                "$titleMessage",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "$subTitleMessage",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80, bottom: 10),
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                color: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        "Réessayer",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

buildButton({VoidCallback? onPressed, var text, Color? color, var context}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 45,
      width: context,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          "$text",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}
