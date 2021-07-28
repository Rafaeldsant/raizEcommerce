import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/source/global.dart' as global;
import 'package:raiz_ecommerce/routes/routes.dart' as rota;
import 'package:raiz_ecommerce/source/functions.dart' as functions;

class EmpresasConteudo extends StatefulWidget {
  dynamic empresa;

  EmpresasConteudo(this.empresa);

  @override
  createState() => EmpresasConteudoState(empresa);
}

class EmpresasConteudoState extends State<EmpresasConteudo> with TickerProviderStateMixin {
  dynamic empresa;

  var respostas = [];

  double containerHeight = 800.0;

  int duracao_detalhamento = 600;
  bool _showProfile;
  dynamic produtoSelecionado;
  var produtos_list = [];

  dynamic dados_produtos_opcoes;
  String conexao_produtos_opcoes;
  bool status_produtos_opcoes;

  dynamic dados_produtos;
  String conexao_produtos;
  bool status_produtos;
  bool aguarde_produtos;

  String tamanhoSelecionado;

  bool favoritado = false;

  bool openSocial = false;

  AnimationController animationController;
  Animation<double> tween;

  EmpresasConteudoState(this.empresa);

  Future<String> getProdutosOpcoes(String metodo, dynamic body) async {
    functions.retorno_aws retorno = await functions.getDataAws(metodo, body);
    if (this.mounted) {
      this.setState(() {
        dados_produtos_opcoes = retorno.dados;
        conexao_produtos_opcoes = retorno.conexao;
        status_produtos_opcoes = retorno.status;

        for (var pergunta in dados_produtos_opcoes['dados_perguntas']) {
          pergunta['global_key'] = new GlobalKey();
        }

        for (var resposta in dados_produtos_opcoes['dados_respostas']) {
          resposta['selecionado'] = false;
        }
      });
    }
  }

  Future<String> getProdutos(String metodo, dynamic body) async {
    functions.retorno_aws retorno = await functions.getDataAws(metodo, body);
    if (this.mounted) {
      this.setState(() {
        dados_produtos = retorno.dados;
        conexao_produtos = retorno.conexao;
        status_produtos = retorno.status;

        aguarde_produtos = false;
      });
    }
  }

  @override
  void initState() {
    _showProfile = false;
    aguarde_produtos = true;

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    tween = Tween<double>(begin: 1, end: 120).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.addListener(() {
      setState(() {});
    });

    this.getProdutos("api_ecommerce/getProdutos", {"empresas_id": empresa['id'].toString()});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: global.cor_primaria,
          title: Text(empresa['fantasia']),
        ),
        floatingActionButton: tamanhoSelecionado != null
            ? FloatingActionButton.extended(
                backgroundColor: global.cor_primaria,
                foregroundColor: Colors.white,
                onPressed: () {
                  // Respond to button press
                },
                icon: Icon(Icons.check),
                label: Text('COMPRAR'),
              )
            : null,
        body: Stack(children: <Widget>[
          if (empresa['img2'] != null)
            Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(empresa['img2']), fit: BoxFit.cover),
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
                                        Padding(
                                            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                                            child: Align(
                                              child: Text(empresa['fantasia'], style: TextStyle(color: Color.fromRGBO(50, 50, 93, 1), fontSize: 28.0), textAlign: TextAlign.center),
                                            )),
                                        SizedBox(height: 10.0),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                                            child: Align(
                                              child: Text(
                                                empresa['slogan'] ?? "",
                                                style: TextStyle(color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.w300),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        SizedBox(height: 20),
                                        socialButton(),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     Icon(Icons.star, size: 25, color: Colors.amber),
                                            //     Text(empresa['avaliacao'] ?? "N/A", style: TextStyle(color: Colors.amber, fontSize: 20.0, fontWeight: FontWeight.w800)),
                                            //   ],
                                            // ),
                                            if (dados_produtos != null)
                                              Column(
                                                children: [
                                                  Text(dados_produtos.length.toString(), style: TextStyle(color: Color.fromRGBO(82, 95, 127, 1), fontSize: 20.0, fontWeight: FontWeight.bold)),
                                                  Text("Produtos", style: TextStyle(color: Color.fromRGBO(50, 50, 93, 1), fontSize: 12.0))
                                                ],
                                              ),
                                            // Row(
                                            //   children: [
                                            //     Icon(FontAwesomeIcons.solidHeart, size: 20, color: Colors.red),
                                            //     SizedBox(width: 5),
                                            //     Text("200", style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.w800)),
                                            //   ],
                                            // ),
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
                                        getProdutosList()
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
                              backgroundImage: NetworkImage(empresa['logomarca']),
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
          AnimatedPositioned(bottom: _showProfile ? 0 : -containerHeight, right: 0, left: 0, duration: Duration(milliseconds: duracao_detalhamento), child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: detalhamentoProduto()))
        ]));
  }

  getProdutosList() {
    if (dados_produtos != null && dados_produtos.length > 0) {
      return GridView.count(shrinkWrap: true, mainAxisSpacing: 5, crossAxisSpacing: 5, childAspectRatio: 0.55, primary: false, padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0), crossAxisCount: 2, children: <Widget>[
        for (int i = 0; i < dados_produtos.length; i++) cardProduto(dados_produtos[i]),
      ]);
    } else {
      return Container();
    }
  }

  getSectionSocial() {
    List social_list = [];
    List<Widget> icons_list = [];

    if (empresa['instagram'] != null) social_list.add({"titulo": "Instagram", "icon": FontAwesomeIcons.instagram, "cor1": '0xffB501A8', "cor2": '0xffE9000E'});
    if (empresa['whatsapp'] != null) social_list.add({"titulo": "Whatsapp", "icon": FontAwesomeIcons.whatsapp, "cor1": '0xff90D573', "cor2": '0xff48A91F'});
    if (empresa['facebook'] != null) social_list.add({"titulo": "Facebook", "icon": FontAwesomeIcons.facebook, "cor1": '0xff4B97E1', "cor2": '0xff2A73BA'});
    if (empresa['twitter'] != null) social_list.add({"titulo": "Twitter", "icon": FontAwesomeIcons.twitter, "cor1": '0xff29A4D9', "cor2": '0xff37C3FF'});
    if (empresa['youtube'] != null) social_list.add({"titulo": "Youtube", "icon": FontAwesomeIcons.youtube, "cor1": '0xffB92A29', "cor2": '0xffEF1A19'});

    for (int i = 0; i < social_list.length; i++) {
      icons_list.add(Center(
          child: AnimatedOpacity(
              opacity: tween.isCompleted ? 1 : 0,
              duration: Duration(milliseconds: !tween.isCompleted ? 100 : 400),
              child: Container(
                  width: 80,
                  margin: EdgeInsets.only(left: i == 0 ? 12 : 5),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    InkWell(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(int.parse(social_list[i]['cor1'])),
                                    Color(int.parse(social_list[i]['cor2'])),
                                  ],
                                ),
                                //border: Border.all(width: 3, color: AppConfig.of(context).corPrincipal),
                                shape: BoxShape.circle,
                              ),
                              child: Center(child: FaIcon(social_list[i]['icon'], color: Colors.white, size: 30)),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (social_list[i]['titulo'] == 'Instagram') functions.open_instagram(empresa['instagram']);
                          if (social_list[i]['titulo'] == 'Whatsapp') functions.open_whatsapp(empresa['whatsapp']);
                          if (social_list[i]['titulo'] == 'Facebook') functions.open_facebook(empresa['facebook']);
                          if (social_list[i]['titulo'] == 'Twitter') functions.open_twitter(empresa['twitter']);
                          if (social_list[i]['titulo'] == 'Youtube') functions.open_youtube(empresa['youtube']);
                        }),
                    SizedBox(height: 5),
                    Row(children: [
                      Expanded(child: Text(social_list[i]['titulo'].toString(), textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]), textAlign: TextAlign.center, maxLines: 2)),
                    ])
                  ])))));
    }
    return icons_list;
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  detalhamentoProduto() {
    if (produtoSelecionado != null) {
      List<String> imgList = [];

      if (produtoSelecionado['img1'] != null) imgList.add(produtoSelecionado['img1'].toString());
      if (produtoSelecionado['img2'] != null) imgList.add(produtoSelecionado['img2'].toString());
      if (produtoSelecionado['img3'] != null) imgList.add(produtoSelecionado['img3'].toString());
      if (produtoSelecionado['img4'] != null) imgList.add(produtoSelecionado['img4'].toString());

      return Column(children: [
        Container(
            transform: Matrix4.translationValues(0.0, 5.0, 0.0),
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(15),
            child: Column(children: [
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
            )),
        Container(
          color: Colors.grey[300],
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (imgList.isNotEmpty)
                  Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.width * 1.2,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: imgList.map((item) => imgWidget(item)).toList(),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Container(padding: EdgeInsets.all(10), child: Icon(favoritado ? Icons.star : Icons.star_border, size: 40, color: Colors.amber.withOpacity(favoritado ? 0.6 : 0.3))),
                            onTap: () {
                              setState(() {
                                favoritado = favoritado ? false : true;

                                produtoSelecionado['loja'] = empresa['nome'];

                                if (!global.favoritos.contains(produtoSelecionado)) {
                                  global.favoritos.add(produtoSelecionado);
                                }
                              });
                            },
                          )),
                    ],
                  ),
                imgDots(imgList),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(produtoSelecionado['nome'], textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("R\$ " + produtoSelecionado['valor_br'], textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green)),
                          SizedBox(height: 10),
                        ],
                      ),
                      InkWell(
                        child: Icon((LineAwesomeIcons.share_square)),
                        onTap: () {
                          // print(produtoSelecionado);
                          compartilharProduto(produtoSelecionado);
                        },
                      ),
                    ]),
                    SizedBox(height: 5),
                    Container(child: Text(produtoSelecionado['descricao'])),
                    if (dados_produtos_opcoes != null) sectionPerguntas(dados_produtos_opcoes),
                    SizedBox(height: 20),
                    purchaseButton(),
                    SizedBox(height: 20),
                  ]),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
          height: containerHeight,
        )
      ]);
    } else {
      return Container();
    }
  }

  var item_key_list = [];
  AnimationController controller;
  var animation_controller_key_list = [];

  Widget sectionPerguntas(dynamic perguntas) {
    List<Widget> perguntas_list = [];

    animation_controller_key_list.clear();

    if (perguntas['dados_perguntas'].length > 0) {
      for (var i = 0; i < perguntas['dados_perguntas'].length; i++) {
        controller = new AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

        final Animation<double> offsetAnimation = new Tween(begin: 0.0, end: 5.0).chain(CurveTween(curve: Curves.elasticIn)).animate(controller);

        animation_controller_key_list.add({"perguntas_id": perguntas['dados_perguntas'][i]['id'], "controller": controller});

        perguntas_list.add(Column(children: [
          SizedBox(height: 20),
          AnimatedBuilder(
              animation: offsetAnimation,
              builder: (buildContext, child) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  padding: EdgeInsets.only(top: offsetAnimation.value + 5.0, bottom: 5.0 - offsetAnimation.value),
                  child: Row(key: perguntas['dados_perguntas'][i]['global_key'], children: [
                    Text('${perguntas['dados_perguntas'][i]['pergunta']}', textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold, color: offsetAnimation.value != 0 ? Colors.red : null)),
                    Text(perguntas['dados_perguntas'][i]['obrigatorio'] == 1 ? '*' : '', textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  ]),
                );
              }),
          Row(children: [
            Wrap(children: [
              for (var r = 0; r < perguntas['dados_respostas'].length; r++)
                if (perguntas['dados_respostas'][r]['produtos_perguntas_id'] == perguntas['dados_perguntas'][i]['id']) containerOpcoes(perguntas['dados_perguntas'][i], perguntas['dados_respostas'][r], 5),
            ]),
          ]),
          SizedBox(height: 10),
        ]));
      }
    } else {
      perguntas_list.add(Container());
    }

    return Column(children: perguntas_list);
  }

  Widget compartilharProduto(dynamic produto) {
    String msg = 'Olha o que eu vi no Raiz E-commerce:\n'
        '${produto['nome']}\n'
        '${produto['descricao']}\n'
        'R\$${produto['valor_br']}\n'
        '${produto['img1']}';

    functions.compartilharTexto(msg);
  }

  Widget imgDots(List<String> imgList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  Widget imgWidget(String img) {
    return Column(children: [
      Stack(children: [
        Container(
            height: MediaQuery.of(context).size.width * 1.2,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(img), fit: BoxFit.fitHeight, alignment: Alignment.center),
            )),
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black.withOpacity(0.3),
                ], stops: [
                  0.0,
                  1.0
                ]),
                color: Colors.white),
            height: MediaQuery.of(context).size.width * 1.2)
      ]),
    ]);
  }

  var opcoes_marcadas = [];

  _verificaquant(String perguntas_id, String quant, String tipo, {String respostas_id: null}) {
    int count = 0;

    if (opcoes_marcadas.length > 0) {
      if (tipo == 'unico') {
        for (int p = 0; p < opcoes_marcadas.length; p++) {
          if (opcoes_marcadas[p]['perguntas_id'].toString() == perguntas_id.toString() && opcoes_marcadas[p]['respostas_id'].toString() != respostas_id.toString()) {
            count++;
          }
        }
      } else {
        for (int p = 0; p < opcoes_marcadas.length; p++) {
          if (opcoes_marcadas[p]['perguntas_id'].toString() == perguntas_id.toString()) {
            count++;
          }
        }
      }

      if (count >= int.parse(quant)) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  _desmarcaUltimo(String perguntas_id, dynamic opcoes) {
    if (opcoes_marcadas.length > 0) {
      for (int p = 0; p < opcoes.length; p++) {
        if (opcoes[p]['selecionado'] && opcoes[p]['produtos_perguntas_id'].toString() == perguntas_id) {
          setState(() {
            opcoes[p]['selecionado'] = false;
          });
        }
      }
    }
  }

  containerOpcoes(dynamic perg, dynamic resp, double margin) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: margin, top: margin),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.all(Radius.circular(200)),
          color: resp['selecionado'] ? global.cor_primaria : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Text(resp['resposta'], style: TextStyle(color: resp['selecionado'] ? Colors.white : Colors.black, fontWeight: FontWeight.bold))]),
      ),
      onTap: () {
        setState(() {
          bool result = true;

          if (perg['quant'] > 1) {
            result = _verificaquant(perg['id'].toString(), perg['quant'].toString(), 'unico', respostas_id: resp['id'].toString());
          }

          if (result) {
            setState(() {
              // if(this.mounted) {
              //   bloqueia = false;
              // }

              if (opcoes_marcadas.length > 0) {
                bool find = false;

                for (int p = 0; p < opcoes_marcadas.length; p++) {
                  bool mesma_pergunta = false;
                  bool mesma_resposta = false;

                  if (opcoes_marcadas[p]['perguntas_id'] == perg['id']) {
                    mesma_pergunta = true;
                  }

                  if (opcoes_marcadas[p]['respostas_id'] == resp['id']) {
                    mesma_resposta = true;
                  }

                  if (mesma_pergunta && mesma_resposta) {
                    opcoes_marcadas.remove(opcoes_marcadas[p]);
                    resp['selecionado'] = false;
                    find = true;
                  }

                  if (perg['quant'] == 1) {
                    if (mesma_pergunta && !mesma_resposta) {
                      _desmarcaUltimo(perg['id'].toString(), dados_produtos_opcoes['dados_respostas']);
                      opcoes_marcadas.remove(opcoes_marcadas[p]);
                    }
                  }
                }

                if (!find) {
                  resp['selecionado'] = true;
                  opcoes_marcadas.add({'perguntas_id': perg['id'], 'respostas_id': resp['id'], 'quant': "1", 'itens_id': produtoSelecionado['id'], 'valor': resp['valor']});
                }
              } else {
                resp['selecionado'] = true;
                opcoes_marcadas.add({'perguntas_id': perg['id'], 'respostas_id': resp['id'], 'quant': "1", 'itens_id': produtoSelecionado['id'], 'valor': resp['valor']});
              }
            });
          }

          print(opcoes_marcadas);
        });
      },
    );
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
      tamanhoSelecionado = null;
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
                    image: DecorationImage(image: CachedNetworkImageProvider(produto['img1']), fit: BoxFit.cover),
                  ))
            ],
          ),
          Container(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Icon(Icons.star, size: 20, color: Colors.amber),
                    //         Icon(Icons.star, size: 20, color: Colors.amber),
                    //         Icon(Icons.star, size: 20, color: Colors.amber),
                    //         Icon(Icons.star, size: 20, color: Colors.amber),
                    //         Icon(Icons.star_border, size: 20, color: Colors.amber),
                    //       ],
                    //     ),
                    //     Text('(20)')
                    //   ],
                    // ),
                    SizedBox(height: 5),
                    Row(children: [Expanded(child: Text('Cod: ' + (produto['codbar'] ?? ""), textScaleFactor: .9, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[800])))]),
                    Row(children: [Expanded(child: Text(produto['nome'], textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.w800)))]),
                    SizedBox(height: 5),
                    Row(
                      children: [Expanded(child: Text('R\$ ' + produto['valor_br'], textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green)))],
                    )
                  ])))
        ],
      ),
      onTap: () {
        setState(() {
          this.getProdutosOpcoes("api_ecommerce/getProdutosOpcoes", {"empresas_id": empresa['id'].toString(), "produtos_id": produto['id'].toString()});
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

  socialButton() {
    return Column(children: [
      InkWell(
        child: Container(
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]),
            borderRadius: BorderRadius.all(Radius.circular(200)),
            color: openSocial ? global.cor_primaria : Colors.transparent,
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5, right: 6, left: 20),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Contatos', style: TextStyle(color: openSocial ? Colors.white : Colors.grey[600], fontWeight: FontWeight.bold)),
            SizedBox(width: 5),
            Icon(openSocial ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: openSocial ? Colors.white : Colors.grey[600])
          ]),
        ),
        onTap: () {
          setState(() {
            setState(() {
              openSocial = openSocial ? false : true;

              if (animationController.isCompleted)
                animationController.reverse();
              else
                animationController.forward();
            });
          });
        },
      ),
      SizedBox(height: 20),
      Container(
          alignment: Alignment.centerLeft,
          height: tween.value,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Align(alignment: Alignment.center, child: ListView(scrollDirection: Axis.horizontal, shrinkWrap: true, children: getSectionSocial()))),
    ]);
  }

  Widget purchaseButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(
          child: Text("Comprar Agora".toUpperCase(), style: TextStyle(fontSize: 14)),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
              foregroundColor: MaterialStateProperty.all<Color>(global.cor_primaria),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: global.cor_primaria)))),
          onPressed: () {
            if (dados_produtos_opcoes['dados_perguntas'].length > 0 && dados_produtos_opcoes['dados_perguntas'] != null) {
              for (int i = 0; i < dados_produtos_opcoes['dados_perguntas'].length; i++) {
                if (dados_produtos_opcoes['dados_perguntas'][i]['obrigatorio'] == 1) {
                  if (_verificaquant(dados_produtos_opcoes['dados_perguntas'][i]['id'].toString(), dados_produtos_opcoes['dados_perguntas'][i]['quant'].toString(), 'unico')) {
                    Scrollable.ensureVisible(dados_produtos_opcoes['dados_perguntas'][i]['global_key'].currentContext);
                    for (int c = 0; c < animation_controller_key_list.length; c++) {
                      if (animation_controller_key_list[c]['perguntas_id'] == dados_produtos_opcoes['dados_perguntas'][i]['id']) {
                        animation_controller_key_list[c]['controller'].forward(from: 0.0);
                        animation_controller_key_list[c]['controller']
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              animation_controller_key_list[c]['controller'].reverse();
                            }
                          });

                        return;
                      }
                    }
                  }
                }
              }
            }

            functions.open_whatsapp(empresa['whatsapp'], text: "teste");

          }),
    ]);
  }
}
