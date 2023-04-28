import 'package:appmobile/pages/home_page.dart';
import 'package:appmobile/services/auth_service.dart';
import 'package:appmobile/widgets/auth_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mainapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  
  runApp(const MyApp());
}

