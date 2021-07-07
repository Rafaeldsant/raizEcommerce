import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/global.dart' as global;
import 'package:raiz_ecommerce/page_inicio.dart';
import 'package:raiz_ecommerce/page_menu.dart';
import 'package:raiz_ecommerce/page_perfil.dart';
import 'package:raiz_ecommerce/page_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raiz E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: body()
    );
  }
}

body() {
  return Splash();
}

class MyHomePage extends StatefulWidget {
  MyHomePage();


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
            InkWell(child:
            Container(child: Image.asset('assets/logo_verde.png', scale: 1.3)),
                onTap: () {
                  global.favoritos.clear();
            }),
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
      body:_children[_currentIndex],
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

  final List<Widget> _children = [
    PageMenu(),
    PageInicio(),
    PagePerfil()
  ];


}
