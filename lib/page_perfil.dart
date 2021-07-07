import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_rota.dart' as rota;

class PagePerfil extends StatefulWidget {
  PagePerfil();

  @override
  createState() => PagePerfilState();
}

class PagePerfilState extends State<PagePerfil> {
  List dados = [];
  String conexao;
  bool status;
  int cont_erro = 0;

  PagePerfilState();

  @override
  void initState() {
    cont_erro = 0;
    conexao = null;
    status = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dados.clear();
    dados.add({'titulo': 'Meus Dados', 'subtitulo': 'Informações da sua conta', "icone": LineAwesomeIcons.user, "rota": "page_perfil"});
    dados.add({'titulo': 'Favoritos', 'subtitulo': 'Guardamos tudo para você', "icone": LineAwesomeIcons.heart, "rota": "page_favoritos"});
    dados.add({'titulo': 'Sair', 'subtitulo': 'Deseja realizar o logout?', "icone": LineAwesomeIcons.power_off, "rota": "page_logout"});

    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
                padding: EdgeInsets.only(top: 1),
                color: Colors.grey[200],
                child: SafeArea(
                    child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  padding: new EdgeInsets.all(0.0),
                  itemCount: dados.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MyListTitle(dados[index]);
                  },
                )))),
      ],
    );
  }

  Widget MyListTitle(dynamic registro) {
    return Column(
      children: [
        if (registro['titulo'] == 'Sair') SizedBox(height: 20),
        InkWell(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(padding: EdgeInsets.symmetric(horizontal: 15), child: Icon(registro['icone'], color: registro['titulo'] == 'Sair' ? Colors.red : global.cor_primaria, size: 30)),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                registro['titulo'],
                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
                                textScaleFactor: 1.10,
                              ),
                              Text(registro['subtitulo'], style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]), textScaleFactor: 1),
                            ],
                          )),
                      if (registro['badge'].toString() == "1")
                        Container(
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.only(right: 8, left: 2),
                        child: Icon(Icons.arrow_forward_ios, color: global.cor_secundaria, size: 15),
                      )
                    ],
                  ),
                ],
              )),
          onTap: () {
            registro['context'] = context;
            rota.getRota(registro);
          },
        )
      ],
    );
  }
}
