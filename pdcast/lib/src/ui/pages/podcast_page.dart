import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/core/utils/utils.dart';
import 'package:pdcast/src/ui/pages/podcast_lista_page.dart';
import 'package:pdcast/src/ui/widgets/titulo_widget.dart';
import 'package:provider/provider.dart';

class PodCastPage extends StatefulWidget {
  final PodCast podCast;

  PodCastPage(this.podCast);

  @override
  _PodCastPageState createState() => _PodCastPageState();
}

class _PodCastPageState extends State<PodCastPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String _nome, _resumo, _categoria;
  String _mensagemErro = "";

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _categoria = _dropDownMenuItems[0].value;
    super.initState();
  }

  /*
   * LISTAR CATEGORIAS 
   */
  List _categorias = [
    Utils.categoriaArte,
    Utils.categoriaBiologia,
    Utils.categoriaFisica,
    Utils.categoriaGeografia,
    Utils.categoriaHistoria,
    Utils.categoriaIngles,
    Utils.categoriaMatematica,
    Utils.categoriaPortugues,
    Utils.categoriaQuimica
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  // here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _categorias) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  // Seta na categoria a selecionada
  void changedDropDownItem(String selected) {
    setState(() {
      _categoria = selected;
      print("categoria: $_categoria");
    });
  }

  /*
   * SALVAR CANAL 
   */
  _salvarDados() {
    if (_key.currentState.validate()) {
      if (_categoria.isEmpty) {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }

      // Sem erros na validação
      _key.currentState.save();

      DateTime now = DateTime.now();
      int dia= now.day;
      int mes= now.month;
      int ano= now.year;

      // Salva os dados no firebase
      final provider = Provider.of<PodCastService>(context);

      PodCast podcast = PodCast(resumo: _resumo, categoria: _categoria, nome: _nome,
        dataCriacao: "$dia/$mes/$ano", idAutor: "sssss", nomeAutor: "TAT", pathAudio: "PATHAUDIO");

      provider.addPodCast(podcast)
      .then((_) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PodCastListaPage()),
          )) 

      .catchError((e) {
        print("Got error: ${e.error}");
        setState(() {
          _mensagemErro =
              "Erro ao cadastrar o podCast, verifique os campos e tente novamente!";
        }); 
      });

    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
            backgroundColor: Color(0xff795548),
            title: Text('PdCast > Meu podCast'),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
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

  // Monta o formulárioblzMas
  Widget _formUI() {
    return Column(
      children: <Widget>[
        TituloWidget(texto: "Cadastrar podCast"),
        TextFormField(
          decoration:
              InputDecoration(hintText: 'Nome', border: OutlineInputBorder()),
          keyboardType: TextInputType.text,
          maxLength: 40,
          validator: _validarNome,
          onSaved: (String val) {
            _nome = val;
          },
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Resumo', border: OutlineInputBorder()),
            maxLines: 5,
            maxLength: 300,
            validator: _validarDescricao,
            onSaved: (String val) {
              _resumo = val;
            }),
        DropdownButton(
          value: _categoria,
          items: _dropDownMenuItems,
          onChanged: changedDropDownItem,
        ),
        SizedBox(height: 15.0),
        RaisedButton(
          color: Color(0xff795548),
          textColor: Colors.white,
          disabledColor: Colors.grey,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: _salvarDados,
          child: Text('Salvar'),
        ),
        SizedBox(height: 15.0),
        Center(
          child: Text(
            _mensagemErro,
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
        )
      ],
    );
  }

  String _validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome do podCast";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String _validarDescricao(String value) {
    if (value.length == 0) {
      return "Escreva um resumo";
    }
    return null;
  }
}
