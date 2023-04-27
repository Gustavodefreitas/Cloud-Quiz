import 'package:flutter/material.dart';

import 'Inicial_page.dart';
import 'Perfil_Page.dart';

class HomePage extends StatefulWidget{

   HomePage({ Key? key}) : super(key:key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  int paginaAtual = 0;
  late PageController pc;

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
        children: [
          InicialPage(),
          PerfilPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list),label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'perfil')
        ],
        onTap: (pagina){
          pc.animateToPage(pagina,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease
          );
        },
        backgroundColor: Colors.purple[100],
      ),
    );
  }
}
 