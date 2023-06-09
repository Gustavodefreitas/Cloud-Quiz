import 'package:appmobile/pages/Login_page.dart';
import 'package:appmobile/pages/home_page.dart';
import 'package:appmobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget{
  AuthCheck({Key? key}): super(key: key);
  
  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck>{
  @override
  Widget build(BuildContext context){
    AuthService auth = Provider.of<AuthService>(context);
      
    if(auth.isLoading) 
      return Loading();
    else if(auth.usuario == null) 
      return LoginScreen();
    else
      return HomePage();
    }

    Loading(){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
      );
  }
}