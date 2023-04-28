import 'package:flutter/material.dart';

class InicialPage extends StatefulWidget{

  InicialPage({Key? key}): super(key: key);
  @override
  _InicialPageState createState() => _InicialPageState();

}

  class _InicialPageState extends State<InicialPage>{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('menu'),

        ),
      );
    }
  }
