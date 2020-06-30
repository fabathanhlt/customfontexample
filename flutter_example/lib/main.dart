import 'package:flutter/material.dart';
import 'package:sample_sign_in_apple_id/home_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

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
    String hostUri = 'faba-production.firebaseapp.com';
    String clientId = 'com.faba.loginappleid';
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
        ],  
      ); 
      if (credential.identityToken == null) {
        throw("Can't get identity Token");
      }
        String identityToken = credential.identityToken; 
        PlatformOAuthCredential authCredential = PlatformOAuthCredential( 
          providerId: "apple.com",
          idToken: identityToken,
        );
        final firebaseUser = await FirebaseAuth.instance.signInWithCredential(authCredential);
        if (firebaseUser.user == null) {
          throw("Can't get user firebase");
        }
         Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => HomePage(firebaseUser.user.email)),
        );
    } catch (error) {
      print('${error}');
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
