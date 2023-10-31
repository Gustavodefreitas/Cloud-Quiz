import 'package:appmobile/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_config_b.dart';

class UserService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para cadastrar um novo usuário
  Future<void> cadastrarUsuario(String? id, String nome, String email,String telefone, String Senha) async {
    try {
      await _firestore.collection('user').add({
        'userId':id,
        'nome': nome,
        'email': email,
        'telefone':telefone,
        'points':0,
        'quiz':[]
      });
      print('Usuário cadastrado com sucesso.');
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
    }
  }

      Future<void> salvarQuiz(dynamic answers,dynamic quiz,callback) async {
        try {

          final user = await AuthService().getUsuarioLogado();
          final userFinal = await buscarUsuarioId(user['userId']);
          final data = await FirebaseConfigB.firestoreB.collection('answersUsers').add(({
              'answers':  answers.map((question) {
              return {
                'question': question['question'],
                'answers': question['answer'].map((a){
                  return  {'text': a['text'], 'ansId': a['ansId'], 'value': a['value']};
                }).toList()
              };
            }).toList(),
              'quiz': quiz,
              'date':DateTime.now().toString(),
              'user': {
                'nome':user['nome'],
                'email':user['email'],
              }
          }));

            Map<String, dynamic> quizData = {
              'answers':  answers.map((question) {
              return {
                'question': question['question'],
                'answers': question['answer'].map((a){
                  return  {'text': a['text'], 'ansId': a['ansId'], 'value': a['value']};
                }).toList()
              };
            }).toList(),
              'quiz': quiz,
              'date':DateTime.now().toString()
            };
           
            
          await _firestore.collection('user').doc(userFinal).update({
            'quiz': FieldValue.arrayUnion([quizData])
          });
          callback(true);
          print('Quiz cadastrado com sucesso!.');
        } catch (e) {
          callback(false);
          print('Erro ao cadastrar quiz: $e');
        }
      }

     Future<void> editarUsuario(String taskId, String nome, String email,String telefone, String Senha,callback) async {
    try {

          final user = await AuthService().getUsuarioLogado();
          final userFinal = await buscarUsuarioId(user['userId']);

      await _firestore.collection('user').doc(userFinal).update({
        'nome': nome,
        'email': email,
        'telefone':telefone
      });
      callback(true);
    } catch (e) {
      callback(false);
    }
  }




 Future<void> deletarUsuario(String taskId) async {
    try {
      await _firestore.collection('user').doc(taskId).delete();
    } catch (e) {
      print('Erro ao deletar tarefa: $e');
    }
  }
  // Método para buscar todos os usuários
  Future<dynamic> buscarUsuario(id) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('user').where('userId', isEqualTo: id).get();

     return querySnapshot?.docs[0];
    } catch (e) {
      print('Erro ao buscar usuários: $e');
      return [];
    }
  }

   Future<dynamic> buscarUsuarioId(id) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('user').where('userId', isEqualTo: id).get();

     return querySnapshot?.docs[0].id;
    } catch (e) {
      print('Erro ao buscar usuários: $e');
      return [];
    }
  }
}
