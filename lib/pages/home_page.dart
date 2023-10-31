import 'package:appmobile/models/quiz.dart';
import 'package:appmobile/pages/Perfil_Menu.dart';
import 'package:appmobile/pages/dashboard_page.dart';
import 'package:appmobile/services/home_service.dart';
import 'package:flutter/material.dart';

import 'Inicial_page.dart';
import 'Perfil_Page.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget{

   HomePage({ Key? key}) : super(key:key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  int paginaAtual = 0;
  late PageController pc;
  List<Quiz> quizzes = [];

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    
  }

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(      
      body: PageView(
        controller: pc,
        allowImplicitScrolling: true,
        children: [
          DashboardPage(),
          InicialPage(),
          PerfilMenuPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
          type: BottomNavigationBarType.fixed, // Define o tipo como fixed
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard ,color: paginaAtual == 0? Colors.red:Colors.black),label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.home,color: paginaAtual == 1? Colors.red:Colors.black),label: 'Quizzes'),
          BottomNavigationBarItem(icon: Icon(Icons.list,color: paginaAtual == 2? Colors.red:Colors.black), label: 'Perfil')
        ],
        onTap: (pagina){
          pc.animateToPage(pagina,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease
          );
        },
        backgroundColor: Colors.white,
      ),
    );
  }
}
 