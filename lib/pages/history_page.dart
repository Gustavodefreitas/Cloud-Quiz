// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/home_service.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    setPaginaAtual(1);
  }

  dynamic user = {};
  bool isDisabled = false;
  List<dynamic> quizzes = [];
  dynamic setPaginaAtual(pagina) async {
    user = await AuthService().getUsuarioLogado();
    quizzes = user['quiz'];

    setState(() {
      quizzes = quizzes.reversed.toList();
      user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Cor de fundo personalizada
        title: Text('Histórico de Quizzes'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(2),
        child: ListView.builder(
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index]['quiz'];
            dynamic date = quizzes[index]['date'];
            dynamic title = quiz['title'];
            dynamic dificuldade = quiz['level']['name'];
            dynamic time = quiz['time']['hours'].toString() == '0'
                ? 'Indeterminado'
                : quiz['time']['hours'].toString();
            dynamic approvalPercentage = quiz['approvalPercentage'].toString();
            dynamic questionsAmount = quiz['questionsAmount'].toString();
            dynamic total = 0;
            dynamic correctCalc = 0;
            dynamic incorrectCalc = 0;
            dynamic approve = 0;
            dynamic percentage = 0;
            user['quiz'].forEach((el) => {
                  if (el['quiz']['title'] == quiz['title'])
                    {
                      el['answers'].forEach((f) => {
                            total = total +
                                f['answers']
                                    .where((filt) => filt['value'] == true)
                                    .toList()
                                    .length +
                                f['answers']
                                    .where((filt) => filt['value'] == false)
                                    .toList()
                                    .length,
                            correctCalc = correctCalc +
                                f['answers']
                                    .where((filt) => filt['value'] == true)
                                    .toList()
                                    .length,
                            incorrectCalc = f['answers']
                                .where((filt) => filt['value'] == false)
                                .toList()
                                .length
                          }),
                      percentage = el['quiz']['approvalPercentage'],
                      approve =
                          (correctCalc / total) * 100 >= percentage ? 1 : 0,
                    }
                });

            return Container(
                margin: EdgeInsets.all(5),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.white, width: 1),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.white, width: 1),
                  ),
                  backgroundColor:approve==0? Color(0xFFff0c44):Colors.green,
                  collapsedBackgroundColor: approve==0? Color(0xFFff0c44):Colors.green,
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  tilePadding: EdgeInsets.only(left: 10),

                  childrenPadding:
                      EdgeInsets.zero, // Reduz o espaço interno dos filhos
                  title: ListTile(
                    trailing: null,
                    leading: null,
                    contentPadding: EdgeInsets.all(
                        3), // Reduz o espaço interno do ExpansionTile
                    minVerticalPadding: 5,

                    textColor: Colors.white,
                    title: Text(
                      quiz['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('Respondido em: ${date}'),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double
                            .infinity, // Isso define a largura como 100% do pai
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                            Text(
                              "Acertos: $correctCalc/$total",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Dificuldade: $dificuldade',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Aprovação: $percentage %',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              
                              approve == 0?'Reprovado':'Aprovado',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
 Center(
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.pushNamed(context, '/inicial',arguments:{'results':'true','quiz':quiz,'quizDisabled':quizzes[index]});
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary:approve == 0? Color(0xFFff0c44):Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Ver Resultados',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),                          ],
                        ),
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
