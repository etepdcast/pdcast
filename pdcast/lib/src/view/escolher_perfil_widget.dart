import 'package:flutter/material.dart';

class EscolherPerfilWidget extends StatefulWidget {
  @override
  _EscolherPerfilWidgetState createState() => _EscolherPerfilWidgetState();
}

class _EscolherPerfilWidgetState extends State<EscolherPerfilWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromRGBO(160,198,207, 1),
          appBar: AppBar(
            title: const Text('ComEsp'),
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Escolha um perfil ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/card_user_yellow.gif')
                                  )
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0.0),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => null),
                                    );                                    
                                  },
                                  child: Container(
                                    child: Text('Paulo André'),
                                  ),
                                ),
                              ),
                              
                              Container(
                                child: Image.asset('assets/card_user_green.gif'),
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                child: Image.asset('assets/card_user_red.gif'),
                                width: 100,
                                height: 100,
                              ), 
                              Container(
                                child: Image.asset('assets/card_user_blue.gif'),
                                width: 100,
                                height: 100,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Image.asset('assets/card_user_blue.gif'),
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                child: Image.asset('assets/card_user_red.gif'),
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                child: Image.asset('assets/card_user_green.gif'),
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                child: Image.asset('assets/card_user_yellow.gif'),
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
    );
  }
}

/*
FlatButton(
  color: Colors.blue,
  textColor: Colors.white,
  disabledColor: Colors.grey,
  disabledTextColor: Colors.black,
  padding: EdgeInsets.all(8.0),
  splashColor: Colors.blueAccent,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeWidget()),
    );
  },
  child: Column(
    children: <Widget>[
      
    Text(
    "Flat Button",
    style: TextStyle(fontSize: 20.0),
  ),
    ],
  )
   
),
*/
