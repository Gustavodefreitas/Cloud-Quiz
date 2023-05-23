import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class PerfilPage extends StatefulWidget{

  PerfilPage({Key? key}): super(key: key);
  @override
  _PerfilPageState createState() => _PerfilPageState();

}

  class _PerfilPageState extends State<PerfilPage>{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('perfil'), 
        ),
        body:Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: OutlinedButton(
                onPressed: () => context.read<AuthService>().logout(),
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Sair do App',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      );
    }
  }
