import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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

  double containerHeight = 800.0;
  int duracao_detalhamento = 600;
  bool _showProfile;
  dynamic produtoSelecionado;
  var produtos_list = [];

  EmpresasConteudoState(this.empresa);

  getProdutos() {
    produtos_list.add({
      "nome": "Midi Dress",
      "nome_completo": "Puff Sleeve Maxi Dress",
      "img": "https://tintofmint.com/wp-content/uploads/2020/08/P8190164-scaled.jpg",
      "codigo": "#1815",
      "valor": "R\$ 90,00",
      "descricao":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic"
    });
    produtos_list.add({"nome": "Puff Dress", "img": "https://i.pinimg.com/564x/89/d5/8d/89d58d942c326913b99db64832ab73bc.jpg", "codigo": "#1815", "valor": "R\$ 90,00"});
    produtos_list.add({"nome": "Long sleeve", "img": "https://i.pinimg.com/564x/e0/f3/f9/e0f3f95a1e50b745cf4386c93751a55f.jpg", "codigo": "#1815", "valor": "R\$ 90,00"});
    produtos_list.add({"nome": "Mini Dress", "img": "https://i.pinimg.com/564x/c7/85/23/c785238575972353d12b39939007cc60.jpg", "codigo": "#1815", "valor": "R\$ 90,00"});
  }

  @override
  void initState() {
    _showProfile = false;
    getProdutos();
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
            child: ListView(shrinkWrap: true, children: [
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
                                              for (int i = 0; i < produtos_list.length; i++) cardProduto(produtos_list[i]),
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
          ),
          AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _showProfile ? 0.8 : 0.0,
              duration: Duration(milliseconds: 300),
              // The green box must be a child of the AnimatedOpacity widget.
              child: returnOverlay()),
          AnimatedPositioned(bottom: _showProfile ? 0 : -containerHeight, right: 0, left: 0, duration: Duration(milliseconds: duracao_detalhamento), child:
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: detalhamentoProduto()
            )
          )
        ]));
  }

  detalhamentoProduto() {
    if (produtoSelecionado != null)
      return Column(children: [
        Container(
          transform: Matrix4.translationValues(0.0, 5.0, 0.0),
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(15),
          child:Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(produtoSelecionado['nome'], textScaleFactor: 1.8, style: TextStyle(fontWeight: FontWeight.bold)),
              InkWell(
                child: Icon((Icons.clear)),
                onTap: () {
                  fecharDetalhamento();
                },
              ),
            ]),
          ]),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white,
          )
        ),
        Container(
          color: Colors.white,
          child:
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(produtoSelecionado['img']), fit: BoxFit.cover, alignment: Alignment.center),
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [
                    SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(produtoSelecionado['nome_completo'], textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(produtoSelecionado['valor'], textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green))
                        ],
                      ),
                      InkWell(
                        child: Icon((LineAwesomeIcons.share_square)),
                        onTap: () {
                          fecharDetalhamento();
                        },
                      ),
                    ]),
                    SizedBox(height: 10),
                    Container(child: Text("Sew-along video tutorial on how to sew this dress using my pattern available on YouTube.")),
                    SizedBox(height: 10),
                  ]),
                )
              ],
            ),
          ),
          height: containerHeight,
        )
      ]);
    else
      return Container();
  }

  returnOverlay() {
    if (_showProfile) {
      return InkWell(
          child: Container(color: Colors.black),
          onTap: () {
            fecharDetalhamento();
          });
    } else {
      return SizedBox(height: 1);
    }
  }

  fecharDetalhamento() {
    setState(() {
      _showProfile = false;
      produtoSelecionado = null;
      duracao_detalhamento = 100;
    });
  }

  cardProduto(dynamic produto) {
    return InkWell(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    image: DecorationImage(image: NetworkImage(produto['img']), fit: BoxFit.cover),
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
                    Row(children: [Expanded(child: Text('Cod: ' + produto['codigo'], textScaleFactor: .9, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[800])))]),
                    Row(children: [Expanded(child: Text(produto['nome'], textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.w800)))]),
                    SizedBox(height: 5),
                    Row(
                      children: [Expanded(child: Text(produto['valor'], textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green)))],
                    )
                  ])))
        ],
      ),
      onTap: () {
        setState(() {
          produtoSelecionado = produto;
          containerHeight = MediaQuery.of(context).size.height * 0.75;
          duracao_detalhamento = 600;
          _showProfile = true;
        });
      },
    );
  }

  _body() {
    return Container();
  }
}
