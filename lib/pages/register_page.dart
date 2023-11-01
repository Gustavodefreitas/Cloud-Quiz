// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final nome = TextEditingController();
  final telefone = TextEditingController();
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState(){
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao){
    setState(() {
      isLogin = acao;
      titulo = 'Crie sua conta';
      actionButton = 'Cadastrar';
      toggleButton = 'Voltar ao login.';
    });
  }


  getSnackBar(text,color){
    return SnackBar(
      content: Text(text),
      backgroundColor: color == "success"?Colors.green:color == "erro"?Color(0xFF149cb0):Colors.blue,
      behavior: SnackBarBehavior.floating, // Define o comportamento como flutuante
      margin: EdgeInsets.all(56.0)); // Define o espaço em relação à parte inferior
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(email.text, senha.text,nome.text,telefone.text,(resp) => {
        if(resp){
          Navigator.pushNamed(context, '/login'),
          ScaffoldMessenger.of(context).showSnackBar(getSnackBar("Usuário cadastrado com sucesso!","success"))
        } else {
           ScaffoldMessenger.of(context).showSnackBar(getSnackBar("Falha ao realizar cadastro, tente novamente mais tarde!","erro"))
        }
      });
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: nome,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Informe o nome corretamente!';
                      }
                      return null;
                    },
                  ),
                ),Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: telefone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefone',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Informe o telefone corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Informe o email corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informa sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                          registrar();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                          ? [
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]
                          : [
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  actionButton,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login') ,
                  child: Text(toggleButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}