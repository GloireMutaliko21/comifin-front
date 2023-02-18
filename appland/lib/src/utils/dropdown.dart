import 'package:app/src/utils/Utils.dart';
import 'package:flutter/material.dart';

import 'CustomField.dart';

Widget cbList({
  List<DropdownMenuItem<String>>? list,
  title,
  String? valeur,
  Function? onChanged,
}) =>
    DropdownButtonFormField(
      isExpanded: true,
      items: list,
      value: valeur,
      onChanged: ((value) => onChanged!(value)),
      hint: Text(
        "$title",
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      decoration: InputDecoration(
        enabledBorder: outlineBorder(color: Colors.grey.shade300),
        focusedBorder: outlineBorder(color: color_green),
        hintText: "$title",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: InputBorder.none,
        // prefixIcon: lineIcons,
        // suffixIcon: ispassword ? iconButton : null,
      ),
      validator: (val) => val == null ? "Ce champs est obligatoire" : null,
    );

List<DropdownMenuItem<String>> listElement({val}) {
  return val.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: val == null || val.isEmpty
          ? const Text("")
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.8),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: color_green,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        value
                            .substring(
                                value.indexOf('-') + 1, value.indexOf('-') + 2)
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    value.substring(value.indexOf('-') + 1),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
    );
  }).toList();
}
