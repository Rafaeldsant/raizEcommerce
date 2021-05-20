import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_rota.dart' as rota;

class PageMenu extends StatefulWidget {
  PageMenu();

  @override
  createState() => PageMenuState();
}

class PageMenuState extends State<PageMenu> {
  List dados = [];
  String conexao;
  bool status;
  int cont_erro = 0;

  PageMenuState();

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
    dados.add({'titulo': 'Parceiros Raiz', 'subtitulo': 'Conheça nossos parceiros', "rota": "parceiros_raiz", "icone": LineAwesomeIcons.pagelines});
    dados.add({'titulo': 'Todas as Lojas', 'subtitulo': 'Encontre tudo que você precisa', "rota": "empresas", "icone": LineAwesomeIcons.shopping_cart});
    dados.add({'titulo': 'Sobre o App', 'subtitulo': 'Saiba mais sobre o Raiz', "rota": "sobre", "icone": LineAwesomeIcons.mobile_phone});

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
    return InkWell(
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
                  Container(padding: EdgeInsets.symmetric(horizontal: 15), child: Icon(registro['icone'], color: global.cor_primaria, size: 30)),
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
    );
  }
}
