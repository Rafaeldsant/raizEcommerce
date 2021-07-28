import 'dart:io';
import 'package:flutter/material.dart';
import 'package:raiz_ecommerce/source/global.dart' as global;

InputDecoration inputDecoration(String hintText, {Widget prefixIcon = null, Widget suffixIcon = null}) {

  return InputDecoration(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey[100],
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500]),
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 15.0, top: 15.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(25.7)),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon
  );
}
