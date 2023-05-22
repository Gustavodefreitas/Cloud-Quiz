import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<void> loadFirebaseAdminConfig() async {
  String jsonString = await rootBundle.loadString('assets/appmobile-10ca0-firebase-adminsdk-xjezq-ccbe222cef.json');
  Map<String, dynamic> config = json.decode(jsonString);
  // Use as configurações da SDK Admin do Firebase aqui
}