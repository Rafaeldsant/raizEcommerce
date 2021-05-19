import 'package:flutter/cupertino.dart';

Color cor_primaria = Color(0xff0F7855);
Color cor_secundaria = Color(0xffE06B27);
Color cor_similar_primaria = Color(0xff2F7855);

Gradient grad_main = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    cor_primaria,
    cor_similar_primaria,
  ],
);
