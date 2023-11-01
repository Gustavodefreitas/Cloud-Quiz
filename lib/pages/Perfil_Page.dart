// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appmobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key? key}) : super(key: key);
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final email = TextEditingController();
  final nome = TextEditingController();
  final telefone = TextEditingController();
  final senha = TextEditingController();
  void initState() {
    super.initState();
    stateInitial();
  }

  dynamic user = {};

  Future stateInitial() async {
    user = await AuthService().getUsuarioLogado();
    setState(() {
      email.text = user["email"] != null ? user["email"] : "";
      nome.text = user["nome"] != null ? user["nome"] : "";
      telefone.text = user["telefone"] != null ? user["telefone"] : "";
    });
  }

  getSnackBar(text, color) {
    return SnackBar(
        content: Text(text),
        backgroundColor: color == "success"
            ? Colors.green
            : color == "erro"
                ? Color(0xFF149cb0)
                : Colors.blue,
        behavior:
            SnackBarBehavior.floating, // Define o comportamento como flutuante
        margin: EdgeInsets.all(
            56.0)); // Define o espaço em relação à parte inferior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Editar Perfil', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Container(
                      height: 250,
                      width: 400,
                      color: Color(0xFF149cb0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(alignment: Alignment.bottomRight, children: [
                              ClipOval(
                                child: Container(
                                  width: 150, // Largura do container
                                  height: 150,
                                  // Altura do container
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'user-icon.png'), // Substitua pelo caminho da sua imagem
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              ClipOval(
                                child: Container(
                                  width: 40, // Largura do container
                                  height: 40,

                                  // Altura do container
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'camera.png'), // Substitua pelo caminho da sua imagem
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(nome.text,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: nome,
                      
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o nome corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      enabled: false,
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: telefone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF149cb0))),
                        labelText: 'Telefone',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF149cb0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Configura os cantos como retos (borda retangular)
                      ),
                      shadowColor: Color(0xFF149cb0)),
                  onPressed: () => context.read<UserService>().editarUsuario(
                      "",
                      nome.text,
                      email.text,
                      telefone.text,
                      "",
                      (resp) => {
                            if (resp)
                              {
                                Navigator.pushNamed(context, '/perfil-menu'),
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(
                                        "Usuário editado com sucesso!",
                                        "success"))
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(
                                        "Falha ao realizar edição, tente novamente mais tarde!",
                                        "erro"))
                              }
                          }),
                  child: Text(
                    'Salvar Alterações',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
