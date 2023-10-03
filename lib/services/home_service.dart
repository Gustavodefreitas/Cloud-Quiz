import 'package:appmobile/firebase_config_b.dart';
import 'package:appmobile/models/quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<List<Map<String, dynamic>>>  loadQuizzes() async {
    final data = await FirebaseConfigB.firestoreB.collection('tests').get();
      final List<Quiz> myObjects = [];
      return data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

  }

}
