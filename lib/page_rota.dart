import 'package:flutter/material.dart';
import 'package:raiz_ecommerce/page_empresas_conteudo.dart';
import 'package:raiz_ecommerce/page_empresas_lista.dart';
import 'package:raiz_ecommerce/page_parceiros_raiz.dart';
import 'package:raiz_ecommerce/page_sobre.dart';

getRota(dynamic dados) {

  print('****************');
  print(dados["rota"]);
  print('****************');

  if(dados == null || dados["rota"] == null || dados["rota"] == "" )
  {
    print('Sem evento');
    return true;
  }

  switch (dados["rota"]) {

    case "parceiros_raiz": { Navigator.of(dados["context"]).push(MaterialPageRoute(builder: (context) => ParceirosRaiz()));   break;}
    case "empresas": { Navigator.of(dados["context"]).push(MaterialPageRoute(builder: (context) => EmpresasLista()));   break;}
    case "sobre": { Navigator.of(dados["context"]).push(MaterialPageRoute(builder: (context) => PageSobre()));   break;}
    case "page_empresas_conteudo": { Navigator.of(dados["context"]).push(MaterialPageRoute(builder: (context) => EmpresasConteudo(dados)));   break;}


    default : {
      showDialog(
          barrierDismissible: false,
          context: dados["context"],
          builder: (context) {
            return AlertDialog(
              content:
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.help, color: Colors.red, size: 50),
                  SizedBox(height: 10.0),
                  Center( child:
                  Text("Seu APP está desatualizado. Existe uma versão mais atualizada do , deseja atualizar agora?", textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),textScaleFactor: 1.2,
                  )
                  )
                ],),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('SIM', style: TextStyle(color: Colors.grey[800]),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('NÃO', style: TextStyle(color: Colors.grey[800])),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      break;
    }
  }
}