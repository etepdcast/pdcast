import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CanalPage extends StatefulWidget {
  @override
  _CanalPageState createState() => _CanalPageState();
}

class _CanalPageState extends State<CanalPage> with SingleTickerProviderStateMixin{
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nome, descricao;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Meu canal'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: _formUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Nome:'),
          maxLength: 40,
          validator: _validarNome,
          onSaved: (String val) {
            nome = val;
          },
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Descrição'),
            maxLength: 100,
            validator: _validarDescricao,
            onSaved: (String val) {
              descricao = val;
            }),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: _sendForm,
          child: new Text('Enviar'),
        )
      ],
    );
  }

  String _validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String _validarDescricao(String value) {
    if (value.length == 0) {
      return "Informe a descricao";
    } 
    return null;
  }

  _sendForm() {
    if (_key.currentState.validate()) {
      // Sem erros na validação
      _key.currentState.save();
      print("Nome $nome");
      print("Descrição $descricao");

      // Salva os dados no firebase
      Firestore.instance.collection("canais").add({"nome":nome, "descricao":descricao});

    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}