import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_rota.dart' as rota;

class EmpresasConteudo extends StatefulWidget {
  dynamic empresa;

  EmpresasConteudo(this.empresa);

  @override
  createState() => EmpresasConteudoState(empresa);
}

class EmpresasConteudoState extends State<EmpresasConteudo> {
  dynamic empresa;

  EmpresasConteudoState(this.empresa);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: global.cor_primaria,
          title: Text(empresa['nome']),
        ),
        body: Stack(children: <Widget>[
          Container(
              height: 250,
              decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"), fit: BoxFit.fitWidth),
          )),
          SafeArea(
            child: ListView(
                shrinkWrap: true,
                children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(),
                        child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Align(
                                          child: Text(empresa['nome'], style: TextStyle(color: Color.fromRGBO(50, 50, 93, 1), fontSize: 28.0)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text(empresa['slogan'], style: TextStyle(color: Color.fromRGBO(50, 50, 93, 1), fontSize: 18.0, fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text("An artist of considerable range, Jessica name taken by Melbourne...",
                                                textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(82, 95, 127, 1), fontSize: 17.0, fontWeight: FontWeight.w200)),
                                          ),
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star, size: 25, color: Colors.amber),
                                                Text(empresa['avaliacao'], style: TextStyle(color: Colors.amber, fontSize: 20.0, fontWeight: FontWeight.w800)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("10", style: TextStyle(color: Color.fromRGBO(82, 95, 127, 1), fontSize: 20.0, fontWeight: FontWeight.bold)),
                                                Text("Produtos", style: TextStyle(color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(FontAwesomeIcons.solidHeart, size: 20, color: Colors.red),
                                                SizedBox(width: 5),
                                                Text("200", style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.w800)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 25.0),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Produtos",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GridView.count(
                                            shrinkWrap: true,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                            childAspectRatio: 8 / 13,
                                            primary: false,
                                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
                                            crossAxisCount: 2,
                                            children: <Widget>[
                                              cardProduto(),
                                              cardProduto(),
                                              cardProduto(),
                                              cardProduto(),
                                              cardProduto(),
                                            ])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(empresa['logo']),
                              radius: 65.0,
                              // maxRadius: 200.0,
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }

  cardProduto() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"), fit: BoxFit.cover),
                ))
          ],
        ),
        Container(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, size: 20, color: Colors.amber),
                          Icon(Icons.star, size: 20, color: Colors.amber),
                          Icon(Icons.star, size: 20, color: Colors.amber),
                          Icon(Icons.star, size: 20, color: Colors.amber),
                          Icon(Icons.star_border, size: 20, color: Colors.amber),
                        ],
                      ),
                      Text('(20)')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(children: [Expanded(child: Text('Cod: #1815', textScaleFactor: .9, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[800])))]),
                  Row(children: [Expanded(child: Text('Nome do produto', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.w800)))]),
                  SizedBox(height: 5),
                  Row(
                    children: [Expanded(child: Text('R\$ 90,00', textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green)))],
                  )
                ])))
      ],
    );
  }

  _body() {
    return Container();
  }
}
