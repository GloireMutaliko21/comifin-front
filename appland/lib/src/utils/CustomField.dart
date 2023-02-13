// Building custom outline borders
// ignore_for_file: unused_element

import 'package:app/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

OutlineInputBorder outlineBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    gapPadding: 0,
    borderSide: BorderSide(
      color: color,
      width: 1,
    ),
  );
}

Widget buildTextField(
    {Icon? lineIcons,
    bool obscureText = false,
    bool ispassword = false,
    String? name,
    bool readOnly = false,
    bool status = false,
    Widget? iconButton,
    TextInputType textInputType = TextInputType.text,
    TextEditingController? controller,
    Widget? child}) {
  return Padding(
    padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 6),
    child: child ??
        TextFormField(
          cursorHeight: 8,
          textCapitalization: TextCapitalization.words,
          keyboardType: textInputType,
          keyboardAppearance: Brightness.light,
          readOnly: readOnly,
          // ignore: prefer_const_constructors
          controller: controller,
          obscureText: obscureText,
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            enabledBorder: outlineBorder(color: Colors.grey.shade300),
            focusedBorder: outlineBorder(color: color_green),
            hintText: "$name",
            floatingLabelAlignment: FloatingLabelAlignment.start,
            border: InputBorder.none,
            prefixIcon: lineIcons,
            suffixIcon: ispassword ? iconButton : null,
          ),
        ),
  );
}
