import 'package:flutter/material.dart';
import 'package:raiz_ecommerce/source/global.dart' as global;
import 'package:raiz_ecommerce/routes/routes.dart' as rota;

class PageSegmento extends StatefulWidget {

  dynamic registro;
  
  PageSegmento(this.registro);

  @override
  createState() => PageSegmentoState(registro);
}

class PageSegmentoState extends State<PageSegmento> {

  dynamic registro;

  PageSegmentoState(this.registro);
  var produtos_list = [];

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

    produtos_list.add({
      "nome": "Puff Dress",
      "nome_completo": "Puff Sleeve Maxi Dress",
      "img": "https://i.pinimg.com/564x/89/d5/8d/89d58d942c326913b99db64832ab73bc.jpg",
      "codigo": "#1815",
      "valor": "R\$ 90,00",
      "descricao":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic"
    });

    produtos_list.add({
      "nome": "Long sleeve",
      "nome_completo": "Puff Sleeve Maxi Dress",
      "img": "https://i.pinimg.com/564x/e0/f3/f9/e0f3f95a1e50b745cf4386c93751a55f.jpg",
      "codigo": "#1815",
      "valor": "R\$ 90,00",
      "descricao":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic"
    });

    produtos_list.add({
      "nome": "Mini Dress",
      "nome_completo": "Puff Sleeve Maxi Dress",
      "img": "https://i.pinimg.com/564x/c7/85/23/c785238575972353d12b39939007cc60.jpg",
      "codigo": "#1815",
      "valor": "R\$ 90,00",
      "descricao":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic"
    });
  }

  @override
  void initState() {
    getProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: global.cor_primaria),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(child: Image.asset('assets/logo_verde.png', scale: 1.3)),
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
        body: _body()
    );
  }

  _body() {
    return SingleChildScrollView(
        child:
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  registro['titulo'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey),
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
      ]));
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
//          produtoSelecionado = produto;
//          containerHeight = MediaQuery.of(context).size.height * 0.75;
//          duracao_detalhamento = 600;
//          _showProfile = true;
        });
      },
    );
  }
}