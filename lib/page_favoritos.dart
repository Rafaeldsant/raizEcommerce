import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_rota.dart' as rota;

class PageFavoritos extends StatefulWidget {
  PageFavoritos();

  @override
  createState() => PageFavoritosState();
}

class PageFavoritosState extends State<PageFavoritos> {
  PageFavoritosState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favoritos"),
          backgroundColor: global.cor_primaria,
        ),
        body: _body());
  }

  _body() {
    if (global.favoritos.length > 0) {
      return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: global.favoritos.length,
        itemBuilder: (BuildContext context, int i) {
          return new Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Column(children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Image.network(global.favoritos[i]['img']),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(children: [
                              Column(children: [
                                Row(children: [Expanded(child: Text(global.favoritos[i]['nome'], textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.w800)))]),
                                Row(children: [Expanded(child: Text('Cod: ' + global.favoritos[i]['codigo'], textScaleFactor: .9, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[800])))]),
                                Row(children: [Expanded(child: Text(global.favoritos[i]['loja'], textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.w800)))]),
                              ]),
                              Row(
                                children: [Expanded(child: Text(global.favoritos[i]['valor'], textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green)))],
                              )
                            ])),
                      ),
                      Container(
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Icon(Icons.star, size: 20, color: Colors.amber),
                        Text("4,5", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w800)),
                      ]))
                    ],
                  )),
                ),
                onTap: () {
                  global.favoritos[i]['context'] = context;
                  global.favoritos[i]['rota'] = 'page_empresas_conteudo';

                  rota.getRota(global.favoritos[i]);
                },
              ),
              Divider(height: 1),
            ]),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Apagar',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  if (global.favoritos.contains(global.favoritos[i])) {
                    setState(() {
                      global.favoritos.remove(global.favoritos[i]);
                    });
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      return Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LineAwesomeIcons.star, size: 40, color: Colors.grey[500]),
                SizedBox(height: 10),
                Text('Desculpe. Você ainda não possui produtos favoritados.', textScaleFactor: 1.1, style: TextStyle(color: Colors.grey[500]), textAlign: TextAlign.center,)
              ])
        ),
      );
    }
  }
}
