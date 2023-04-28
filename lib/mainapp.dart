import 'package:appmobile/pages/home_page.dart';
import 'package:appmobile/widgets/auth_check.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio do projeto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.purple,
      ),
      home:HomePage(),
    );
  }
}

