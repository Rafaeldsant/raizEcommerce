import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raiz_ecommerce/source/global.dart' as global;
import 'package:raiz_ecommerce/routes/routes.dart' as rota;

class PageSobre extends StatefulWidget {

  PageSobre();

  @override
  createState() => PageSobreState();
}

class PageSobreState extends State<PageSobre> {

  PageSobreState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: _body());
  }

  _body() {
    return
      Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/bg_sobre.jpg", fit: BoxFit.fitHeight),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.white.withOpacity(0.6),
                ], stops: [
                  0.0,
                  0.5
                ]),
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  InkWell(child:
                  Container(
                      child: Icon(Icons.arrow_back, color: global.cor_primaria),
                      margin: EdgeInsets.only(top: 30, left: 15),
                      width: 30.0,
                      height: 30.0,
                      decoration: new BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        shape: BoxShape.circle,
                      )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
                InkWell(
                  child: Image.asset("assets/logo_verde.png"),
                  onTap: () => {
                  },
                ),
                Column(children: [
                  botaoWidget("Fale Conosco", "fale_conosco",Icons.headset_mic),
                  botaoWidget("Compartilhar","compartilhar", Icons.share),
                  botaoWidget("Avaliar Aplicativo","avaliar", Icons.star),
                  botaoWidget("Conheça Mais","propaganda", Icons.add_comment),
                ]),
                Column(
                  children: [
                    Text('Raiz Ecommerce ®',textScaleFactor: 0.9, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                    SizedBox(height: 5),
                    Text('Versão: 1.0', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),textScaleFactor: 0.9)
                  ],
                ),
              ],
            )
          ]);
  }

  botaoWidget(String titulo, String tipo, IconData icone) {
    return InkWell(child:
    Row(
        children: [
          Expanded(child:
          Container(
              decoration: BoxDecoration(
                  color: global.cor_primaria,
                  borderRadius: BorderRadius.all(Radius.circular(150))
              ),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              padding: EdgeInsets.all(13),
              child: Row(children: [
                Icon(icone, color: Colors.white),
                Expanded(
                    child: Center(
                        child:Container(margin: EdgeInsets.only(right: 25),
                            child: Text(titulo, textScaleFactor: 1.2, style: TextStyle(color: Colors.white))
                        )
                    )
                )])
          )
          )
        ]),
      onTap: () {
        if(tipo == "fale_conosco") {
          dynamic sobre = json.decode('{"titulo":"Fale Conosco"}');
//          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageRedesSociais(sobre)));
        } else if (tipo == "compartilhar"){
//          function.compartilharTexto("", context, add_msg_download: true);
        } else if (tipo == "avaliar"){
//          function.open_site(Platform.isIOS ? global.urlApple : global.urlGoogle);
        } else if (tipo == "propaganda"){
//          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PagePropaganda()));
        }
      },
    );
  }
}