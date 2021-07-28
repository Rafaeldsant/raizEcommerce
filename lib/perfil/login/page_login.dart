import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:raiz_ecommerce/source/estilo.dart';
import 'package:raiz_ecommerce/source/global.dart' as global;
import 'package:raiz_ecommerce/routes/routes.dart' as rota;

class PageLogin extends StatefulWidget {
  PageLogin();

  @override
  createState() => PageLoginState();
}

class PageLoginState extends State<PageLogin> {
  PageLoginState();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return _formLogin();
  }

  String _validarEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.trim().length == 0) {
      return "Email não informado";
    } else if (value.trim().length > 0 && !regExp.hasMatch(value.trim())) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String _validarSenha(String value) {
    value = value.replaceAll(" ", "");
    if (value.length == 0) {
      return "Senha não informada";
    } else if (value.length < 6) {
      return "Mínimo de 6 caracteres";
    } else {
      return null;
    }
  }

  Widget _formLogin() {
    return Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            new Text(
              'Login de Acesso',
              textAlign: TextAlign.left,
              style: TextStyle(color: global.cor_primaria, fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: new TextFormField(
                decoration: inputDecoration('E-mail',
                    prefixIcon: Icon(
                      LineAwesomeIcons.envelope,
                      color: global.cor_primaria,
                    )),
                keyboardType: TextInputType.text,
                validator: _validarEmail,
                onSaved: (String val) {
                  // email = val.trim();
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: new TextFormField(
                onTap: () {
                  setState(() {
                    _validate = false;
                  });
                },
                decoration: inputDecoration('Senha',
                    prefixIcon: Icon(
                      LineAwesomeIcons.lock,
                      color: global.cor_primaria,
                    )),
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: _validarSenha,
                onSaved: (String val) {
                  // senha = val;
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(global.cor_secundaria),
                    elevation: MaterialStateProperty.all(5),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ))),
                onPressed: _sendForm,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.userCheck, color: Colors.white, size: 15),
                    Text(
                      "    Entrar",
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.2,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Criar uma conta",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  onTap: () {
                    //_navigateCadastro(context);
                  },
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Esqueci a Senha",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  onTap: () => {
                    setState(() {
                      // exibe_recuperar_senha = true;
                    })
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            // new TextFormField(decoration: InputDecoration(helperText: "Senha", hintText:"Senha", hintStyle: TextStyle(color: Colors.grey[400],fontSize: 14)),keyboardType: TextInputType.text,validator: _validarEmail,onSaved: (String val) {email = val;},),
          ],
        ));
  }

  _sendForm() {
    try {
      if (_key.currentState.validate()) {
        // Sem erros na validação
        _key.currentState.save();

        // this.login("api_ecommerce/loginUsuario", {"email": email.trim(), "senha": senha});
      } else {
        setState(() {
          _validate = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
