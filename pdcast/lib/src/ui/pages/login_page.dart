import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdcast/src/RouteGenerator.dart';
import 'package:pdcast/src/core/models/usuario.dart';
import 'package:pdcast/src/core/services/usuario_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  _setUser(FirebaseUser user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", user.uid);
    prefs.setString("nome", user.displayName);
  }

  // Example code of how to sign in with google.
  Future<String> _signInWithGoogle() async {

    String _userId= "";
    
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    // assert(user.email != null);
    // assert(user.displayName != null);
    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);

    // final FirebaseUser currentUser = await _auth.currentUser();
    // assert(user.uid == currentUser.uid);
    _userId = user.uid;
    
    _setUser(user);

    // print("$_userId == $currentUser.uid");
    // print("= = = = = => _userID => $_userId");

    setState(() {
      if (user != null) {
        // Salva os dados no firebase
        final provider = Provider.of<UsuarioService>(context);

        DateTime now = DateTime.now();
        int dia = now.day;
        int mes = now.month;
        int ano = now.year;

        Usuario usuario = Usuario(
            nome: user.displayName,
            ativo: true,
            dataCadastro: "$dia/$mes/$ano");

        provider.addUsuario(_userId, usuario).then((_) {
          print("Usuario inserido no firebase $_userId");
        });
      } 

    });
    return _userId;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,      
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff795548),
          title: Text('PdCast'),
          automaticallyImplyLeading: true),
        body: Container(
          child: FutureBuilder(
            future: _signInWithGoogle(),
            initialData :"Verificando login do google...",
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String text= snapshot.data;
                print(" = = = = = = =  = = = = = = = = = = = = = = ");
                print(" = = = = = = = E N V I A D O  $text = = = = ");
                print(" = = = = = = =  = = = = = = = = = = = = = = "); 

                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                });

                return Center(
                  child: Text(
                      "Login realizado com sucesso",
                      style: TextStyle(fontSize: 20.0),
                  ),
                );                               
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
                //Navigator.of(context).pushNamed("/home");
                // return Center(
                //     child: Text(
                //        snapshot.data,
                //        style: TextStyle(fontSize: 20.0),
                //     ),
                //   );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
        ),
      ),
    );
  }
}
