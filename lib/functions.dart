//
//open_ligar(String telefone) async {
//
//  if(telefone == null || telefone.isEmpty)
//    return;
//
//  if(telefone.length > 9 && telefone.substring(0,1) != "0")
//    telefone = "0"+telefone;
//
//  var url = "tel:"+telefone;
//  if (await canLaunch(url)) {
//    await launch(url);
//  } else {
//    throw 'Could not launch $url';
//  }
//}
//
//open_whatsapp(String whatsapp) async {
//  var url = "whatsapp://send?phone=55"+whatsapp;
//  await canLaunch(url) ? launch(url) : print("Erro abrindo WhatsApp");
//}
//
//open_site(String url) async {
//  if(url != null && url != ""){
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
//}