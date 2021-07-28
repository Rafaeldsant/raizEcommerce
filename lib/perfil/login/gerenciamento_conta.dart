import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/perfil/login/page_login.dart';
import 'package:raiz_ecommerce/perfil/login/page_perfil.dart';
import 'package:raiz_ecommerce/source/global.dart' as global;
import 'package:raiz_ecommerce/routes/routes.dart' as rota;

class GerenciamentoConta extends StatefulWidget {
  GerenciamentoConta();

  @override
  createState() => GerenciamentoContaState();
}

class GerenciamentoContaState extends State<GerenciamentoConta> {
  List dados = [];
  String conexao;
  bool status;
  int cont_erro = 0;

  GerenciamentoContaState();

  @override
  void initState() {
    cont_erro = 0;
    conexao = null;
    status = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      if(1 == 2) {
        return PagePerfil();
      } else {
        return PageLogin();
      }
  }

}
