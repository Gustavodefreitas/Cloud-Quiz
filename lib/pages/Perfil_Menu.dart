// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:appmobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilMenuPage extends StatefulWidget {
  PerfilMenuPage({Key? key}) : super(key: key);
  @override
  _PerfilMenuPageState createState() => _PerfilMenuPageState();
}

class _PerfilMenuPageState extends State<PerfilMenuPage> {

  @override
  void initState() {
    super.initState();
    stateInitial();
  }

  dynamic usuario = {"nome":""};
  String nome = "aaaaa";

  Future stateInitial() async {
    final usuarioGet = await AuthService().getUsuarioLogado();
  
   setState(() {
         usuario = usuarioGet;
         nome = usuario["nome"];
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Perfil', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          automaticallyImplyLeading: false,

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                FractionallySizedBox(
                widthFactor: 1.0,
                child: Container(
                  color: Color(0xFF149cb0),
                  height: 80,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: 
                  Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    
                    children: [
                    ClipOval(
                          child: Container(
                            width: 40, // Largura do container
                            height: 40,
                             // Altura do container
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/user-icon.png'), // Substitua pelo caminho da sua imagem
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size:24,
                                    color: Colors.white,
                                  ),
                                  Text(usuario["points"].toString(),style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                 fontWeight: FontWeight.bold
                              ),)
                                ],
                              ),Text(nome,style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,

                              ),)
                          ],
                        ),)
                  ],)
                ),),
                ),
              FractionallySizedBox(
              widthFactor: 1.0,
               // 50% de largura
              child: Container(

                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),),
                
                child: 
                GestureDetector(
                onTap: () => {
                   Navigator.pushNamed(context, '/perfil'),
                },
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child:Icon(Icons.edit, size: 24)),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]),
              ),),
            ),
            
              FractionallySizedBox(
              widthFactor: 1.0, // 50% de largura
              child: Container(
                height: 50,
                 decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),),
                child: 
                GestureDetector(
                  onTap: () => {
                     Navigator.pushNamed(context, '/history'),

                  },
                  child: Row(children: [
                  
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child:Icon(Icons.history, size: 24)),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Histórico',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ]),),
              ),
            ),FractionallySizedBox(
              widthFactor: 1.0, // 50% de largura
              child: Container(
                height: 50,
                 decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),),
                child: 
                GestureDetector(
                  onTap: () => {
                    context.read<AuthService>().logout(),
                     Navigator.pushNamed(context, '/login'),

                  },
                  child: Row(children: [
                  
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child:Icon(Icons.logout, size: 24)),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Sair da Conta',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ]),),
              ),
            ),
          ],
        ));
  }
}
