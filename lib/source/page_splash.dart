import 'dart:async';
import 'dart:io';
import 'package:raiz_ecommerce/source/global.dart' as global;

import 'package:flutter/material.dart';
import 'package:raiz_ecommerce/main.dart';
import 'package:raiz_ecommerce/source/functions.dart' as functions;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  String msg;
  String cidades_id_aux;
  String municipios_id_aux;
  String limpar_cache_cidade_aux;

  List dados;
  bool conectou;
  bool status;
  bool internet;
  bool exibe_botao_tentar_novamente = false;

  List dados_municipios;
  bool conectou_municipios;
  bool status_municipios;
  bool internet_municipios;

  List dados_config;
  String conexao_config;
  int cont_erro_config = 0;
  bool status_config;

  bool achou;
  int count_erro = 0;
  dynamic aux;

  dynamic registro;

  navigateToHome() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  conectar_config() {
    this.getConfig("getConfig", {});
  }

  Future<String> getConfig(String metodo, dynamic body) async {
    functions.retorno_aws retorno = await functions.getDataAws(metodo, body, timeout: 3);

    if (!retorno.status && cont_erro_config < 5) {
      setState(() {
        cont_erro_config++;
      });

      Future.delayed(Duration(seconds: 1)).then((_) {
        conectar_config();
      });
    } else if (!retorno.status) {
      setState(() {
        exibe_botao_tentar_novamente = true;
      });
    } else {
      if (this.mounted) {
        this.setState(() {
          cont_erro_config = 0;
          dados_config = retorno.dados;
          conexao_config = retorno.conexao;
          status_config = retorno.status;

          if (retorno.dados != null) {
//            global.msg_atualizar = retorno.dados[0]['atualizar'] == 1 ? true : false;
//            global.mensagem_home = dados_config[0]["mensagem_home"];
//            global.msg_cadastro_empresa = dados_config[0]["msg_cadastro_empresa"];
//            global.urlApple = dados_config[0]["url_apple"];
//            global.urlGoogle = dados_config[0]["url_google"];
//            global.whatsapp = dados_config[0]["whatsApp"];
//            global.telefone = dados_config[0]["telefone"];
//            global.email = dados_config[0]["email"];
//            global.cep_cadastrese = dados_config[0]["cep_cadastrese"];
//            global.latitude = dados_config[0]["latitude"];
//            global.longitude = dados_config[0]["longitude"];
//            global.cnpj_obrigatorio = dados_config[0]["cnpj_obrigatorio_empresa"];
//            global.ecommerce = dados_config[0]["ecommerce"] == 1 ? true : false;
//            global.classificados = dados_config[0]["classificados"] == 1 ? true : false;
//            global.instagram = dados_config[0]["instagram"];
//            global.facebook = dados_config[0]["facebook"];
//            global.youtube = dados_config[0]["youtube"];
//
//            global.texto_compartilhar = dados_config[0]["texto_compartilhar"];
//            global.texto_compartilhar_loteria = dados_config[0]["texto_compartilhar_loteria"];
//            global.texto_compartilhar_tempo = dados_config[0]["texto_compartilhar_tempo"];
//            global.texto_compartilhar_telefone = dados_config[0]["texto_compartilhar_telefone"];
//            global.texto_compartilhar_emprego = dados_config[0]["texto_compartilhar_emprego"];
//            global.texto_compartilhar_comercio = dados_config[0]["texto_compartilhar_comercio"];
//            global.texto_compartilhar_servico = dados_config[0]["texto_compartilhar_servico"];
//            global.texto_compartilhar_entrega = dados_config[0]["texto_compartilhar_entrega"];
//            global.texto_compartilhar_ecommerce = dados_config[0]["texto_compartilhar_ecommerce"];
//            global.texto_compartilhar_classificados = dados_config[0]["texto_compartilhar_classificado"];
//            global.texto_compartilhar_promocao = dados_config[0]["texto_compartilhar_promocao"];
//            global.texto_compartilhar_cupom = dados_config[0]["texto_compartilhar_cupom"];
//            global.texto_whatsapp_empresa = dados_config[0]["texto_whatsapp_empresa"];


//            print(global.texto_whatsapp_empresa);

//            global.param_cadastrese_home = dados_config[0]["param_cadastrese_home"];
//
//            global.titulo_cadastro_empresa = dados_config[0]["titulo_cadastro_empresa"];
//            global.sub_titulo_cadastro_empresa = dados_config[0]["sub_titulo_cadastro_empresa"];
//
//            if (dados_config[0]["cor_principal"] != null) {
//              AppConfig.of(context).corPrincipal = Color(int.parse(dados_config[0]["cor_principal"]));
//              global.corPrincipal = AppConfig.of(context).corPrincipal;
//            }
//
//            if (dados_config[0]["cor_secundaria"] != null) {
//              AppConfig.of(context).corSecundaria = Color(int.parse(dados_config[0]["cor_secundaria"]));
//              global.corSecundaria = AppConfig.of(context).corSecundaria;
//            }
//
//            if (dados_config[0]["municipios_id"] != null) {
////              print(dados_config[0]["municipios_id"]);
//              print("municipios_nome:" + dados_config[0]["municipios_nome"]);
//              global.municipios_id = dados_config[0]["municipios_id"].toString();
//              global.municipios_nome = dados_config[0]["municipios_nome"].toString();
//              global.municipios_uf = dados_config[0]["municipios_uf"].toString();
//            } else {
//              print('VAZIO');
//            }
//
////            print(global.municipios_nome);
////            print(global.municipios_uf);
//
//            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//
//            if (dados_config[0]["compartilhar"].toString() == "0") {
//              global.compartilhar = false;
//            } else {
//              if (Platform.isIOS) {
//                global.compartilhar = global.device == 'iphone' ? true : false;
//              } else {
//                global.compartilhar = true;
//              }
//            }
//
//            if (global.compartilhar == true && ((Platform.isIOS && dados_config[0]["url_apple"] != null && dados_config[0]["url_apple"] != "") || (Platform.isAndroid && dados_config[0]["url_google"] != null && dados_config[0]["url_google"] != ""))) {
//              global.compartilhar = true;
//            } else {
//              global.compartilhar = false;
//            }
            navigateToHome();
          }
        });

      }
    }
  }

  conectar() async {

    if (count_erro > 3) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        conectar_config();
      });
    } else {
      count_erro++;
      conectar();
    }
  }

  @override
  initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    cidades_id_aux = "";

    try {
        conectar();
    } catch (e) {
      conectar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, stops: [0.1, 0.8], colors: [global.cor_primaria, global.cor_primaria.withAlpha(210)]),
      ),
      child: FadeTransition(
          opacity: animation,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            "assets/logo_branco.png",
                            scale: 1,
                          ),
                          ))),
              if (cont_erro_config > 0 && !exibe_botao_tentar_novamente)
                Stack(children: [
                  Container(
                    height: 40,
                    color: Colors.white,
                  ),
                  Row(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2 * (cont_erro_config - 1),
                      height: 40,
                      color: global.cor_secundaria,
                    )
                  ]),
                  Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            height: 40,
                            child: Text(
                              "Problema na conexão com a internet,\ntentando novamente",
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ))
                ]),
              if (exibe_botao_tentar_novamente)
                GestureDetector(
                    onTap: () {
                      setState(() {
                        cont_erro_config = 0;
                        exibe_botao_tentar_novamente = false;
                        conectar_config();
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Row(children: [
                        Expanded(
                          child: Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: global.cor_secundaria,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Não foi possivel conectar ao servidor!",
                                      textScaleFactor: 0.9,
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      "Clique aqui para conectar novamente",
//                              textScaleFactor: 0,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(child: Icon(Icons.refresh, size: 30))
                              ])),
                        )
                      ]),
                    ))
            ],
          )),
    );
  }

  Color getTextColor(Color color) {
    int d = 0;

    double luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(color.alpha, d, d, d);
  }
}
