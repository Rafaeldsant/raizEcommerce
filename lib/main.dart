import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_menu.dart';
import 'package:raiz_ecommerce/page_perfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var imagens_list = [];
  var destaques_list = [];

  var imagens_list_aux = [];

  int _currentIndex = 1;

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: global.cor_primaria),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(child: Image.asset('assets/logo_verde.png', scale: 1.5)),
          ]),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/outros/avatar.jpg'),
              ))
        ],
      ),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: global.cor_secundaria,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(LineAwesomeIcons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(LineAwesomeIcons.user), label: 'Perfil'),
        ],
      ),
    );
  }

  body() {
    if (_currentIndex == 0) {
      return PageMenu();
    } else if (_currentIndex == 1) {
      return SingleChildScrollView(
          child: Container(child:
            Column(children: [
              searchBar(),
              destaqueSection(),
              sectionComponent('Feminino', 'feminino'),
              sectionComponent('Masculino', 'masculino'),
              sectionComponent('Marcas Brasileiras', 'mb')
            ])
          )
      );
    } else {
      return PagePerfil();
    }
  }

  searchBar() {
    return Column(children: [
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: TextField(
          onChanged: (value) {},
          controller: editingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[100],
              hintText: "Busca Raiz",
              hintStyle: TextStyle(color: Colors.grey[500]),
              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(25.7)),
              prefixIcon: Icon(Icons.search, color: global.cor_primaria),
              suffixIcon: GestureDetector(
                onTap: () {},
                child: Icon(Icons.arrow_forward, color: global.cor_primaria),
              )),
        ),
      )
    ]);
  }

  destaqueSection() {
    var destaques_list_aux = getDestaquesConteudo();

    print(destaques_list_aux);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Destaques', textScaleFactor: 1.8, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  color: global.cor_primaria,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(children: [Text('Seja Patrão', textScaleFactor: 1.2, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), SizedBox(width: 5), Icon(Icons.star, size: 20, color: Colors.white)]))
          ])),
      SizedBox(height: 20),
      Container(height: 100, child: ListView(scrollDirection: Axis.horizontal, children: [for (int i = 0; i < destaques_list_aux.length; i++) destaquesCards(destaques_list_aux[i], i)]))
    ]);
  }

  getDestaquesConteudo() {
    destaques_list.clear();

    destaques_list.add({"titulo": "Roupas", "icon": FontAwesomeIcons.tshirt});
    destaques_list.add({"titulo": "Casa", "icon": FontAwesomeIcons.home});
    destaques_list.add({"titulo": "Esporte", "icon": FontAwesomeIcons.running});
    destaques_list.add({"titulo": "Livros", "icon": FontAwesomeIcons.book});
    destaques_list.add({"titulo": "Artes", "icon": FontAwesomeIcons.palette});

    var cores_principais = ['0xffC80092', '0xff00401C', '0xff401903', '0xffD45B15'];
    var cores_secundarias = ['0xff8C0E6A', '0xff00602C', '0xff5B2104', '0xffFF9658'];

    int cor_index = 0;

    for (int i = 0; i < destaques_list.length; i++) {
      if (cor_index > 3) {
        cor_index = 0;
      }

      destaques_list[i]['cor1'] = cores_principais[cor_index];
      destaques_list[i]['cor2'] = cores_secundarias[cor_index];

      cor_index++;
    }

    return destaques_list;
  }

  destaquesCards(dynamic dados_destaques, int index) {
    return Container(
        width: 80,
        margin: EdgeInsets.only(left: index == 0 ? 12 : 5),
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
                          Color(int.parse(dados_destaques['cor1'])),
                          Color(int.parse(dados_destaques['cor2'])),
                        ],
                      ),
                      //border: Border.all(width: 3, color: AppConfig.of(context).corPrincipal),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: FaIcon(dados_destaques['icon'], color: Colors.white)),
                  ),
                ],
              ),
              onTap: () {}),
          SizedBox(height: 5),
          Row(children: [
            Expanded(child: Text(dados_destaques['titulo'].toString(), textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]), textAlign: TextAlign.center, maxLines: 2)),
          ])
        ]));
  }

  sectionComponent(String titulo, String tipo) {
    imagens_list_aux = getImagens(tipo);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(titulo, textScaleFactor: 1.8, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(children: [Text('Ver tudo', textScaleFactor: 1.2, style: TextStyle(color: global.cor_secundaria, fontWeight: FontWeight.bold)), Icon(Icons.arrow_forward_ios, size: 15, color: global.cor_secundaria)])
          ])),
      photoGrid(imagens_list_aux)
    ]);
  }

  photoGrid(List imagens) {
    if (imagens.length > 0)
      return Container(
          height: 180,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            SizedBox(width: 12),
            Wrap(direction: Axis.vertical, children: [
              for (int i = 0; i < imagens.length; i++)
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 2.0, offset: Offset(0, 2), spreadRadius: 0.0)], borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.white),
                        margin: EdgeInsets.all(3),
                        width: 120,
                        height: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            child: Image.asset(
                              imagens[i]['img'],
                              fit: BoxFit.cover,
                            ))),
                    if (imagens[i]['titulo'] != null && imagens[i]['titulo'] != "")
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.black.withOpacity(0.6),
                              ], stops: [
                                0.0,
                                1.0
                              ]),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Colors.white),
                          margin: EdgeInsets.all(3),
                          width: 120,
                          height: 80,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                imagens[i]['titulo'],
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              )),
                        ),
                        onTap: () {},
                      ),
                  ],
                )
            ])
          ]));
    else
      return Container();
  }

  getImagens(String tipo) {
    imagens_list.clear();

    if (tipo == 'feminino') {
      imagens_list.add({"titulo": "Camisas", "img": "assets/categorias/feminino/camisas.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Óculos", "img": "assets/categorias/feminino/oculos.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Saias", "img": "assets/categorias/feminino/saias.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Sapatos", "img": "assets/categorias/feminino/sapatos.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Saltos", "img": "assets/categorias/feminino/saltos.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Vestidos", "img": "assets/categorias/feminino/vestidos.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Acessórios", "img": "assets/categorias/feminino/acessorios.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Chapéus", "img": "assets/categorias/feminino/chapeus.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Cosméticos", "img": "assets/categorias/feminino/cosmeticos.png", "rota": "page_comercio_antiga"});
    } else if (tipo == 'masculino') {
      imagens_list.add({"titulo": "Camisas", "img": "assets/categorias/masculino/camisas.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Bermudas", "img": "assets/categorias/masculino/bermudas.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Tênis", "img": "assets/categorias/masculino/tenis.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Bonés", "img": "assets/categorias/masculino/bones.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Calças", "img": "assets/categorias/masculino/calcas.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Casacos", "img": "assets/categorias/masculino/casacos.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "Beleza", "img": "assets/categorias/masculino/beleza.png", "rota": "page_comercio_antiga"});
    } else {
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
      imagens_list.add({"titulo": "", "img": "assets/categorias/mb/mb_default.png", "rota": "page_comercio_antiga"});
    }

    return imagens_list;
  }
}
