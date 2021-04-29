import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_rota.dart' as rota;

class ParceirosRaiz extends StatefulWidget {
  ParceirosRaiz();

  @override
  createState() => ParceirosRaizState();
}

class ParceirosRaizState extends State<ParceirosRaiz> {
  ParceirosRaizState();

  var parceiros = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Parceiros Raiz"),
          backgroundColor: global.cor_primaria,
        ),
        body: _body());
  }

  _body() {
    parceiros.clear();
    parceiros.add({'nome': "Farm Brasil" ,"categoria": "Esportes" ,"slogan": "Slogan do parceiro", "logo": "https://149352187.v2.pressablecdn.com/wp-content/uploads/2012/03/logo-loja-farm.jpg", "avaliacao": "4.8", "novo": false});
    parceiros.add({'nome': "YouCom"      ,"categoria": "Casa"     ,"slogan": "Slogan do parceiro", "logo": "https://rastrearmeupedido.com/wp-content/uploads/2018/02/youcom.png", "avaliacao": "4.2", "novo": false});
    parceiros.add({'nome': "Dalu Ateliê" ,"categoria": "Moda Feminina" ,"slogan": "Slogan do parceiro", "logo": "https://s3-sa-east-1.amazonaws.com/projetos-artes/fullsize%2F2014%2F08%2F04%2F14%2FLogo-LV-76627_34049_050958320_1836532817.png", "avaliacao": "4.6", "novo": true});
    parceiros.add({'nome': "Hering"      ,"categoria": "Roupas" ,"slogan": "Slogan do parceiro", "logo": "https://static.hering.com.br/store/_ui/responsive/theme-hering/images/square-logo-hering.jpg", "avaliacao": "4.7", "novo": false});
    parceiros.add({'nome': "Floratta Modas"      ,"categoria": "Moda Feminina" ,"slogan": "Slogan do parceiro", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLTDC3K_GtyS2W2pcoG1pzzlBHdkPomvGLVA&usqp=CAU", "avaliacao": "4.6", "novo": true});

    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: parceiros.length,
      itemBuilder: (BuildContext context, int i) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(parceiros[i]['logo']),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(' ' + parceiros[i]['nome'], style: TextStyle(fontWeight: FontWeight.w800)),
                          Text(' ' + parceiros[i]['slogan'], style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400)),
                          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Icon(Icons.star, size: 20, color: Colors.amber),
                            Text(parceiros[i]['avaliacao'], style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w800)),
                            SizedBox(width: 3),
                            Icon(Icons.lens, size: 3, color: Colors.grey[800]),
                            SizedBox(width: 5),
                            Text(parceiros[i]['categoria'], style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                          ])
                        ]),
                      ),
                    ),
                      Expanded(
                          flex: 1,
                          child:
                    parceiros[i]['novo'] ?
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: global.cor_secundaria,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text('Novo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ])) : Container()
                      ),
                  ],
                )),
          ),
          Divider(height: 1),
        ]);
      },
    );
  }
}
