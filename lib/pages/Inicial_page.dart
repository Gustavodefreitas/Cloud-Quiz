import 'package:flutter/material.dart';

class InicialPage extends StatefulWidget{

  InicialPage({Key? key}): super(key: key);
  @override
  _InicialPageSate createState() => _InicialPageSate();

}

  class _InicialPageSate extends State<InicialPage>{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('menu'),

        ),
      );
    }
  }
