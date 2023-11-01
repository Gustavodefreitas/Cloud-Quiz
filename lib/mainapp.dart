import 'package:appmobile/pages/Login_page.dart';
import 'package:appmobile/pages/Perfil_Menu.dart';
import 'package:appmobile/pages/Perfil_Page.dart';
import 'package:appmobile/pages/dashboard_page.dart';
import 'package:appmobile/pages/home_page.dart';
import 'package:appmobile/pages/register_page.dart';
import 'package:appmobile/widgets/auth_check.dart';
import 'package:flutter/material.dart';

import 'pages/Inicial_page.dart';
import 'pages/history_page.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: "Cloud quiz",
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Rota inicial
      routes: {
        '/login': (context) => LoginScreen(),
        '/history': (context) => HistoryPage(),
        '/register': (context) => RegisterScreen(),
        '/perfil': (context) => PerfilPage(),
        '/home': (context) => HomePage(),
        '/inicial':(context) => InicialPage(),
        '/dashboard': (context) => DashboardPage(),
        '/perfil-menu': (context) => PerfilMenuPage(),
        // Defina outras rotas conforme necessário
      },
      theme: ThemeData(
        
      ),
      home:AuthCheck(),  //  home:LoginScreen(),
    );
  }
}
