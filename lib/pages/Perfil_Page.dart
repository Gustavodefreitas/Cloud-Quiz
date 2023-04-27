import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget{

  PerfilPage({Key? key}): super(key: key);
  @override
  _PerfilPageSate createState() => _PerfilPageSate();

}

  class _PerfilPageSate extends State<PerfilPage>{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('perfil'),

        ),
      );
    }
  }
