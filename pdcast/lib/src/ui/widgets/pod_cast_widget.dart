import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/utils/size_config.dart';
import 'package:pdcast/src/core/utils/utils.dart';

class PodCastWidget extends StatefulWidget {
  final PodCast podCast;
  const PodCastWidget({Key key, @required this.podCast});

  @override
  _PodCastWidgetState createState() => _PodCastWidgetState();
}

class _PodCastWidgetState extends State<PodCastWidget> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _tocando= false;
  bool _favorito= false;
  
  @override
  Widget build(BuildContext context) {
    // Verifica o espaco disponivel para o texto
    double widthText = SizeConfig(context: context).getWidth() - 170;

    // Seleciona a imagem relativa ao post
    String imagem = 'assets/edfisica.png';
    if (Utils.removerCaracteresEspeciais(Utils.categoriaArte) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/arte.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaBiologia) ==
        widget.podCast.categoria) {
      imagem = 'assets/bio.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaEducFisica) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/edfisica.png';
    } else if (Utils.removerCaracteresEspeciais(
            Utils.categoriaEmpreendedorismo) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/empreendedorismo.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaFilosofia) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/filosofia.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaFisica) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/fisica.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaGeografia) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/geo.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaHistoria) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/historia.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaIngles) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/ingles.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaMatematica) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/edfisica.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaPortugues) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/portugues.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaQuimica) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/quimica.png';
    } else if (Utils.removerCaracteresEspeciais(Utils.categoriaSociologia) ==
        Utils.removerCaracteresEspeciais(widget.podCast.categoria)) {
      imagem = 'assets/sociologia.png';
    } else {
      imagem = 'assets/logo.png';
    }

    _play(String url) async {
      int result = await _audioPlayer.play(url);
      if (result == 1) {
        _tocando= true;
      }
    }

    _pause(String url) async {
      int result = await _audioPlayer.pause();
      if (result == 1) {
        _tocando= false;
      }
    }    

    _gerenciarFavorito(String id) async {
      if (_favorito) {
        _favorito= false;
      } else {
        _favorito= true;
      }
    }

    return Container(
        padding: EdgeInsets.all(2),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Container(
                  child: Row(children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(imagem))),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Column(children: <Widget>[
                          Container(
                            width: widthText,
                            child: Text(
                              widget.podCast.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: widthText,
                            child: Text(
                              widget.podCast.nomeAutor,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ]))
                  ]),
                ),
                Container(
                  child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                    child: IconButton(
                      icon: Icon(
                        _tocando ? Icons.pause : Icons.play_circle_outline
                        ),
                      highlightColor: Colors.pink,
                      onPressed: () {
                        setState(() {
                          _tocando ? _pause(widget.podCast.pathAudio) : 
                                     _play(widget.podCast.pathAudio);
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                    child: IconButton(
                      icon: Icon(
                        _favorito ? Icons.favorite : Icons.favorite_border
                      ),
                      highlightColor: Colors.pink,
                      onPressed: () {
                        setState(() {
                          _gerenciarFavorito(widget.podCast.id);
                        });                        
                      },
                    ),
                  ),
                ]))
              ],
            )));
  }
}
