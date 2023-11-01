import 'dart:math';

import 'package:appmobile/services/auth_service.dart';
import 'package:appmobile/services/home_service.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
    void initState(){
    super.initState();
    stateInitial();
  }
  dynamic user = {};
  dynamic quizzes = {};
  dynamic correct = 0;
  dynamic incorrect = 0;
  dynamic quizFeito = 0;
  dynamic quizPendente = 0;
  dynamic totalQuiz = 0;
  dynamic approve = 0;
  dynamic percentage = '';
  dynamic total= 0;

  Future stateInitial() async {
    user = await AuthService().getUsuarioLogado();
    quizzes = await HomeService().loadQuizzes();
  

    setState(() {
      quizzes = quizzes;
      user = user;
      quizPendente = (quizzes.length - user['quiz'].length);
      quizFeito = user['quiz'].length;
      totalQuiz = quizzes.length;
        });

    num incorrectCalc;
    num correctCalc;

    user['quiz'].forEach((el) => {
      total = 0,
      correctCalc = 0,
      incorrectCalc = 0,
      el['answers'].forEach((f) => {
        total = total+ f['answers'].where((filt) => filt['value'] == true).toList().length + f['answers'].where((filt) => filt['value'] == false).toList().length,
        correct = correct + f['answers'].where((filt) => filt['value'] == true).toList().length,
        incorrect = incorrect + f['answers'].where((filt) => filt['value'] == false).toList().length,
        correctCalc = correctCalc + f['answers'].where((filt) => filt['value'] == true).toList().length,
        incorrectCalc = incorrectCalc + f['answers'].where((filt) => filt['value'] == false).toList().length
      }),
      percentage = el['quiz']['approvalPercentage'],
      approve = (correctCalc/total)*100 > percentage?approve+1:approve,


    });

    

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Dashboard', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 1.0,
              color: const Color(0xFF82c1b8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estatísticas Gerais',
                      style: TextStyle(
                        fontSize: 20.0,
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        StatisticCard(
                          label: 'Quizzes Feitos',
                          value: quizFeito.toString(), // Altere com dados reais
                        ),
                        StatisticCard(
                          label: 'Quizzes Pendentes',
                          value: quizPendente.toString(), // Altere com dados reais
                        ),
                        StatisticCard(
                          label: 'Respostas Corretas',
                          value: correct.toString(), // Altere com dados reais
                        ),
                        StatisticCard(
                          label: 'Respostas Erradas',
                          value: incorrect.toString(), // Altere com dados reais
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              color: Color(0xFF6ca4b4),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progresso dos Quizzes',
                      
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    QuizProgressSlider(
                      label: 'Quizzes Concluídos',
                      completed: quizFeito,
                      total: totalQuiz, 
                      percentage: false,
                    ),
                     QuizProgressSlider(
                      label: 'Taxa de Aprovação',
                      completed: approve > 0 && totalQuiz > 0?((approve/totalQuiz)*100).toInt():0,
                      total: totalQuiz, 
                      percentage:true
                    ) 
                    
                     
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String label;
  final String value;

  StatisticCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.5, // Define a largura como 50% do pai
        child: Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  
                  style: TextStyle(fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )));
  }
}

class QuizProgressSlider extends StatelessWidget {
  final String label;
  final int completed;
  final int total;
  final bool percentage;

  QuizProgressSlider({
    required this.label,
    required this.completed,
    required this.total,
    required this.percentage
  });

  @override
  Widget build(BuildContext context) {
    
    final double progress = total == 0?0:completed / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
             fontWeight: FontWeight.bold,
            color: Colors.white

          ),
        ),
        SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        SizedBox(height: 8.0),
        Text(
          percentage?'$completed%':'$completed de $total',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


class SimplePieChart extends StatelessWidget {
  final double approvedPercentage;
  final double rejectedPercentage;

  SimplePieChart({
    required this.approvedPercentage,
    required this.rejectedPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150, // Altura do gráfico de pizza
      child: CustomPaint(
        painter: PieChartPainter(
          approvedPercentage: approvedPercentage,
          rejectedPercentage: rejectedPercentage,
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double approvedPercentage;
  final double rejectedPercentage;

  PieChartPainter({
    required this.approvedPercentage,
    required this.rejectedPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintApproved = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final paintRejected = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final approvedAngle = 2 * pi * approvedPercentage;
    final rejectedAngle = 2 * pi * rejectedPercentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      approvedAngle,
      true,
      paintApproved,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      approvedAngle - (pi / 2),
      rejectedAngle,
      true,
      paintRejected,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


