import 'package:flutter/material.dart';
import 'package:pdcast/src/model/podCast.dart';
import 'package:pdcast/src/utils/size_config.dart';

class PodCastWidget extends StatefulWidget {
  final PodCast podCast;
  const PodCastWidget({Key key, this.podCast});
  
  @override
  _PodCastWidgetState createState() => _PodCastWidgetState();
}

class _PodCastWidgetState extends State<PodCastWidget> {

  @override
  Widget build(BuildContext context) {
    print(SizeConfig(context: context).getWidth());
    print(SizeConfig(context: context).getHeight());

    double widthText= SizeConfig(context: context).getWidth() - 100;
    print(widthText);

    return Container( 
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: widthText,
                          child: Text(
                            widget.podCast.nome,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          width: widthText,
                          child: Text(
                            widget.podCast.autor,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
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
                    padding: EdgeInsets.fromLTRB(2, 0, 4, 0),
                    child: Icon(Icons.play_circle_outline),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 0, 2, 0),
                    child: Icon(Icons.favorite_border),
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
