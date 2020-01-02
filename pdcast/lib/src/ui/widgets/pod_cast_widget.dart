import 'package:flutter/material.dart';
import 'package:pdcast/src/model/podCast.dart';
import 'package:pdcast/src/utils/size_config.dart';
import 'package:pdcast/src/utils/utils.dart';

class PodCastWidget extends StatefulWidget {
  final PodCast podCast;
  const PodCastWidget({Key key, this.podCast});
  
  @override
  _PodCastWidgetState createState() => _PodCastWidgetState();
}

class _PodCastWidgetState extends State<PodCastWidget> {

  @override
  Widget build(BuildContext context) {

    // Verifica o espaco disponivel para o texto
    double widthText= SizeConfig(context: context).getWidth() - 170;

    // Seleciona a imagem relativa ao post
    String imagem= 'assets/edfisica.png';
    if ( Utils.categoriaArte == widget.podCast.canal.categoria ) {
      imagem= 'assets/arte.png';
    } else if ( Utils.categoriaBiologia == widget.podCast.canal.categoria ) {
      imagem= 'assets/bio.png';
    } else if ( Utils.categoriaFisica == widget.podCast.canal.categoria ) {
      imagem= 'assets/fisica.png';
    } else if ( Utils.categoriaGeografia == widget.podCast.canal.categoria ) {
      imagem= 'assets/geo.png';
    } else if ( Utils.categoriaHistoria == widget.podCast.canal.categoria ) {
      imagem= 'assets/historia.png';
    } else if ( Utils.categoriaIngles == widget.podCast.canal.categoria ) {
      imagem= 'assets/ingles.png';
    } else if ( Utils.categoriaMatematica == widget.podCast.canal.categoria ) {
      imagem= 'assets/edfisica.png';
    } else if ( Utils.categoriaPortugues == widget.podCast.canal.categoria ) {
      imagem= 'assets/portugues.png';
    } else if ( Utils.categoriaQuimica == widget.podCast.canal.categoria ) {
      imagem= 'assets/quimica.png';
    } else {
      imagem= 'assets/logo.png';
    }

    return Container( 
      padding: EdgeInsets.all(2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(imagem))
                    ),
                    // child: FlatButton(
                    //   onPressed: () => Navigator.push(
                    //     context, 
                    //     MaterialPageRoute(builder: (context) => AddCardWidget(model))
                    //   ),
                    //   child: new Text(model.name),
                    // ),
                  ),                    
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
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
                            widget.podCast.autor,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ]
                    )
                  )
                ]
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                    child: IconButton(
                      icon: Icon(Icons.play_circle_outline),
                      highlightColor: Colors.pink,
                      onPressed: ()=> Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => null)
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                    child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      highlightColor: Colors.pink,
                      onPressed: ()=> Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => null)
                      ),
                    ),
                  ),                  
                ]
              )
            )
          ],
        )
      )
    );
  }
}
