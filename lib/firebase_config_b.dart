import 'package:appmobile/firebase-web-options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConfigB {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      name: "projetoB",
      options: DefaultFirebaseOptionsB.currentPlatform,
    );
  }

  static final authB = FirebaseAuth.instanceFor(app: Firebase.app('projetoB'));
  static final firestoreB = FirebaseFirestore.instanceFor(app: Firebase.app('projetoB'));
}
