import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardOptions{
  final String title;
  final String image;
  final String status;
  final String criador;
  const CardOptions({this.title, this.image, this.status, this.criador});
}

class CardWidget extends StatelessWidget{

  final CardOptions options;
  const CardWidget({Key key, this.options}): super(key: key);

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.overline;
    return Card(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            children: <Widget>[
              Container(
                width: 62,
                height: 62,
                color: Colors.white,
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.black.withAlpha(0),
                      Colors.black12,
                      Colors.black45
                    ],
                  ),
                ),
                child: Text(
                  "Channel",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ],
          ),
        )
        //   Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       new Container(
        //         width: 60,
        //         height: 60,
        //         padding: EdgeInsets.all(0),
        //         alignment: Alignment.center,
        //         decoration: new BoxDecoration(
        //           image: DecorationImage(
        //               image: AssetImage('assets/card/'+this.options.image),
        //               fit: BoxFit.fill
        //           ),
        //         ),
        //       ),
        //       Text(options.title),
        //     ]
        //   ),
        // )
      )
    );
  }
}