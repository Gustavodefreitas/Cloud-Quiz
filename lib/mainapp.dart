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
        
        primarySwatch: MaterialColor(
    0xFF149cb0, // Substitua pelo seu valor hexadecimal
    <int, Color>{
      50: Color(0xFFE0F2F2), // Defina as cores para as várias tonalidades, se necessário
      100: Color(0xFFB3E6E6),
      200: Color(0xFF80D9D9),
      300: Color(0xFF4DCBCC),
      400: Color(0xFF26BFBF),
      500: Color(0xFF149cb0), // Cor principal
      600: Color(0xFF129293),
      700: Color(0xFF107576),
      800: Color(0xFF0E5A59),
      900: Color(0xFF0A4642),
    },
  ),
      ),
      home:AuthCheck(),  //  home:LoginScreen(),
    );
  }
}
