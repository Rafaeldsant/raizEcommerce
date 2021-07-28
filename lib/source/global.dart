import 'package:flutter/cupertino.dart';

Color cor_primaria = Color(0xff0F7855);
Color cor_secundaria = Color(0xffE06B27);
Color cor_similar_primaria = Color(0xff2F7855);

dynamic favoritos = [];

Gradient grad_main = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    cor_primaria,
    cor_similar_primaria,
  ],
);

String base_url = "http://192.168.15.5:8000/api/";
String token = "c85a723a9f67fd49b3a88a3b7a7f358b";
