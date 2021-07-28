import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:raiz_ecommerce/source/global.dart' as global;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class retorno_aws{
  bool conectou;
  bool status;
  bool internet;
  bool erro;
  String msg;
  String e;
  dynamic dados;
  String conexao;
}

Future<retorno_aws> getDataAws(String metodo, dynamic body, {String url_api = "",int timeout}) async {

  dynamic resposta;
  retorno_aws retorno = new retorno_aws();

  retorno.internet = true;
  retorno.conectou = false;
  retorno.erro = false;
  retorno.status = false;
  retorno.conexao = null;

  retorno.msg = null;
  retorno.dados = null;
  retorno.e = null;

  final url = url_api == null || url_api == "" ?  global.base_url + metodo : url_api + metodo;

  var response;

  try{

//    body["controle"] = "1";
//    body["versao"] = global.versao;
//    body["imei"] = global.imei;
//    body["usuario_id"] = usuario.id.toString();
//    body["usuarios_id"] = usuario.id.toString();
//    body["usuario_email"] = usuario.email.toString();
//    body["usuario_senha"] = usuario.senha.toString();
//    body["token_principal"] = global.token;
//    body['device'] = global.device;
//    body['device_name'] = global.device_name;
//    body['municipios_id'] = global.municipios_id;

    body["token"] = global.token;
    body['metodo'] = metodo;

    print('XXXXXXXXXXXXXXXX');
    print('Método:'+metodo);
    print(body.toString());
    print(url);
    print('XXXXXXXXXXXXXXXX');


    if(timeout != null){
      response = await http.post(Uri.parse(url) , body: body).timeout(Duration(seconds: timeout));
    } else{
      response = await http.post(Uri.parse(url) , body: body).timeout(const Duration(seconds: 30));
    }

    if(response == null){
      retorno.msg = "Erro conectando a internet";
      retorno.internet = false;
      retorno.conexao = "erro";
    }else if(response.statusCode == 200){
      resposta = json.decode(response.body);
      retorno.conectou = true;
      retorno.status = resposta["status"];
      retorno.msg = resposta["msg"];
      retorno.conexao = "ok";
      if(retorno.status == true) {
        retorno.msg = resposta["msg"] == null ? null : resposta["msg"];
        retorno.dados = resposta["dados"];
      }else{
        retorno.msg = resposta["msg"];
      }
    } else {
      retorno.conexao = "erro";
      retorno.erro = true;
      retorno.msg = "Erro encontrado. Erro: " + response.statusCode.toString();
    }
  } catch( e ) {

    print(e);

    response = null;
    retorno.e = e.toString();
    retorno.conexao = "erro";
    retorno.internet = false;
  }

  return retorno;
}



open_ligar(String telefone) async {

 if(telefone == null || telefone.isEmpty)
   return;

 if(telefone.length > 9 && telefone.substring(0,1) != "0")
   telefone = "0"+telefone;

 var url = "tel:"+telefone;
 if (await canLaunch(url)) {
   await launch(url);
 } else {
   throw 'Could not launch $url';
 }
}

open_whatsapp(String whatsapp, {String text = null}) async {
 var url = "whatsapp://send?phone=55"+whatsapp+"&text="+(text ?? '')+"";
 await canLaunch(url) ? launch(url) : print("Erro abrindo WhatsApp");
}

open_site(String url) async {
 if(url != null && url != ""){
   if (await canLaunch(url)) {
     await launch(url);
   } else {
     throw 'Could not launch $url';
   }
 }
}

open_email(String email) async {

  var url = "mailto:"+email;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

open_facebook(String facebook) async {

  var fbProtocolUrl = Platform.isIOS ?  "fb://profile/"+facebook :"fb://page/"+facebook;
  var fallbackUrl = "https://www.facebook.com/"+facebook;

  try {
    bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

    if (!launched) {
      open_site(fallbackUrl);
    }else{
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false);
  }
}

open_instagram(String instagram) async {
  var url = "http://instagram.com/_u/"+instagram;
  await canLaunch(url) ? launch(url) : print("Erro abrir instagram");
}

open_twitter(String twitter) async {
  var url = "http://twitter.com/"+twitter;
  await canLaunch(url) ? launch(url) : print("Erro abrir instagram");
}

open_youtube(String youtube) async {
  var url = "https://www.youtube.com/"+youtube;
  await canLaunch(url) ? launch(url) : print("Erro abrir youtube");
}

compartilharTexto(String msg) {
  Share.share(msg);
}