import 'package:flutter/material.dart';
import 'package:sample_sign_in_apple_id/home_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:crypto/crypto.dart';
import 'package:sample_sign_in_apple_id/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Apple Id ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key); 

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  void _onClickAuthorizeApple() async { 
    String nonce = "helloworld";
    String sha256Nonce = Utils.getSHA256(nonce); 
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
        ],  
        nonce: sha256Nonce,
      ); 
      if (credential.identityToken == null) {
        throw("Can't get identity Token");
      }
        String identityToken = credential.identityToken;  
       OAuthProvider oAuthProvider = OAuthProvider(providerId: "apple.com");
       final AuthCredential authCredential = oAuthProvider.getCredential(idToken: identityToken, rawNonce: nonce);

        print('authCredential $authCredential');
        final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(authCredential);
        if (authResult.user == null) {
          throw("Can't get user firebase");
        }
         Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => HomePage(credential.email)),
        );
    } catch (error) {
      print('$error');
    }
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Padding(
               padding: EdgeInsets.only(left: 20, right: 20),
               child:SignInWithAppleButton(onPressed: () => {
               _onClickAuthorizeApple()
             })
             ,)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
