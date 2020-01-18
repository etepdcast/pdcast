//import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/core/utils/utils.dart';
import 'package:pdcast/src/ui/pages/podcast_lista_page.dart';
import 'package:pdcast/src/ui/widgets/titulo_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

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
  String _userId, _userNome, _nome, _resumo, _categoria;
  String _mensagemErro = "";

  String _statusUpload = "Upload não iniciado";
  String _urlFileRecuperada = null;

  String _fileName;
  // String _path;
  bool _loadingPath = false;
  bool _hasValidMime = false;
  //FileType _pickingType;
  File _file;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _categoria = _dropDownMenuItems[0].value;
    super.initState();
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString("userId");
      _userNome = prefs.getString("nome");  
      print(" > > > > > > > > > > > > > > > > > > > > > > > >");
      print(" > > > > > >  uid  $_userId = = nome $_userNome = = = =");
    });
  }


  Future _uploadFile() async {
    FirebaseStorage storage= FirebaseStorage.instance;
    StorageReference pastaRaiz= storage.ref();

    StorageReference arquivo= pastaRaiz
      .child("podcasts")
      .child(_categoria)
      .child("$_fileName.mp3");

    //Fazer upload da imagem
    StorageUploadTask task = arquivo.putFile(_file);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent){
      if( storageEvent.type == StorageTaskEventType.progress ){
        setState(() {
          _statusUpload = "Em progresso";
        });
      }else if( storageEvent.type == StorageTaskEventType.success ){
        setState(() {
          _statusUpload = "Upload realizado com sucesso!";
        });
      }
    });

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _recuperarUrlImagem( snapshot );
    });    
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    setState(() {
      _urlFileRecuperada = url;
    });

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

      _getUser();

      _uploadFile();
      
      // Sem erros na validação
      _key.currentState.save();

      DateTime now = DateTime.now();
      int dia= now.day;
      int mes= now.month;
      int ano= now.year;

      // Salva os dados no firebase
      final provider = Provider.of<PodCastService>(context);

      PodCast podcast = PodCast(resumo: _resumo, categoria: _categoria, nome: _nome,
        dataCriacao: "$dia/$mes/$ano", idAutor: _userId, nomeAutor: _userNome, 
        pathFile: _urlFileRecuperada);

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

  void _openFileExplorer() async {
    String _path;
    // if (_pickingType != FileType.CUSTOM || _hasValidMime) {
    //   setState(() => _loadingPath = true);
    //   // String _path = await FilePicker.getFilePath(
    //   //     type: _pickingType, fileExtension: FileType.AUDIO.toString());
    //   _file = await FilePicker.getFile();
    //   _path= _file.uri.path;
    //   print("= = = = = = = = = = = = = = = = = = = = = =");
    //   print("= = = _path  $_path = = = =");
    //   print("= = = = = = = = = = = = = = = = = = = = = =");  

    // }
    // if (!mounted) return;
    // setState(() {
    //   _loadingPath = false;
    //   _fileName = _path.split('/').last;
    //                 print("= = = = = = = = = = = = = = = = = = = = = =");
    //   print("= = = _fileName  $_fileName = = = =");
    //   print("= = = = = = = = = = = = = = = = = = = = = =");  
    // });
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
            backgroundColor: Color(0xff795548),
            title: Text('PdCast > Meu podCast'),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PodCastListaPage()),
                ),
            )),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: Column(
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
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () => _openFileExplorer(),
                      child: new Text("Localizar arquivo"),
                    ),
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
              ),
            ),
          ),
        ),
      ),
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

