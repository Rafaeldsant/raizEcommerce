import 'package:flutter/material.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_rota.dart' as rota;
import 'package:raiz_ecommerce/functions.dart' as functions;

class EmpresasLista extends StatefulWidget {
  EmpresasLista();

  @override
  createState() => EmpresasListaState();
}

class EmpresasListaState extends State<EmpresasLista> {
  EmpresasListaState();


  dynamic registro;
  List dados;
  String conexao;
  String msg;
  int cont_erro = 0;
  bool status;

  @override
  void initState() {
    super.initState();
    conectar();
  }

  Future<String> getData(String metodo, dynamic body) async {
    functions.retorno_aws retorno = await functions.getDataAws(metodo, body);

    if (this.mounted) {
      this.setState(() {
        dados = retorno.dados;
        conexao = retorno.conexao;
        status = retorno.status;
        msg = retorno.msg;

      });
    }
  }

  conectar() {

    this.getData("getEmpresas", {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Empresas"),
          backgroundColor: global.cor_primaria,
        ),
        body: _body());
  }

  _body() {

    if(dados == null || dados.length == 0) {
      return Container();
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: dados.length,
        itemBuilder: (BuildContext context, int i) {

          if(dados[i]['categorias'] != null) {
            var cats = dados[i]['categorias'].split(',');
            print(cats);

            dados[i]['categorias'] = cats[0] + (cats.length > 1 ? ' e mais ${cats.length}' : '');
          }


          return Column(children: [
            InkWell(
              child: Padding(
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
                              backgroundImage: NetworkImage(dados[i]['logomarca']),
                            ),
                          ]),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(' ' + dados[i]['fantasia'], style: TextStyle(fontWeight: FontWeight.w800)),
                              Text(' ' + (dados[i]['slogan'] ?? ""), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400), maxLines: 1, overflow: TextOverflow.ellipsis),
                              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Icon(Icons.star, size: 20, color: Colors.amber),
                                Text(dados[i]['avaliacao'] ?? 'N/A', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w800)),
                                SizedBox(width: 3),
                                Icon(Icons.lens, size: 3, color: Colors.grey[800]),
                                SizedBox(width: 5),
                                Text(dados[i]['categorias'] ?? "", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                              ])
                            ]),
                          ),
                        ),
//                        Expanded(
//                            flex: 1,
//                            child:
//                            dados[i]['novo'] ?
//                            Container(
//                                margin: EdgeInsets.symmetric(horizontal: 10),
//                                decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.all(Radius.circular(5)),
//                                  color: global.cor_secundaria,
//                                ),
//                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                                child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: [
//                                      Text('Novo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                                    ])) : Container()
//                        ),
                      ],
                    )),
              ),
              onTap: () {
                dados[i]['context'] = context;
                dados[i]['rota'] = 'page_empresas_conteudo';

                rota.getRota(dados[i]);
              },
            ),
            Divider(height: 1),
          ]);
        },
      );
    }

  }
}
