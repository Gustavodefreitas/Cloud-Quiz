// ignore_for_file: deprecated_member_use

/*import 'package:appmobile/pages/home_page.dart';
import 'package:appmobile/services/auth_service.dart';
import 'package:appmobile/widgets/auth_check.dart';
import 'package:provider/provider.dart';*/

import 'package:appmobile/firebase_config_b.dart';
import 'package:appmobile/services/auth_service.dart';
import 'package:appmobile/services/user_service.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'mainapp.dart';



void main() async {
   // Inicialize o Firebase para "Projeto B"

  FirebaseConfigB.initialize();
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (content) => UserService())
      ],
    child: const MyApp(),
    ),
  );
}

