import 'package:appmobile/models/quiz.dart';
import 'package:appmobile/services/auth_service.dart';
import 'package:appmobile/services/home_service.dart';
import 'package:appmobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InicialPage extends StatefulWidget {
  InicialPage({Key? key}) : super(key: key);
  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  List<dynamic> quizzes = [];
  dynamic quizSelected = {};
  bool showQuiz = false;
  bool showQuiz2 = false;
  bool showResults = false;

  static var title = '';
  static var dificuldade = '';
  static var time = '';
  static var approvalPercentage = '';
  static var questionsAmount = '';
 
  @override
  void initState() {
    super.initState();
    setPaginaAtual(1);
  }
  dynamic user = {};
  bool isDisabled = false;
  dynamic quizDisabled= {};

  setPaginaAtual(pagina) async {
      quizzes = await HomeService().loadQuizzes();
      user = await AuthService().getUsuarioLogado();
    setState(() {
      quizzes = quizzes;
    });
  }


  getSnackBar(text,color){
    return SnackBar(
      content: Text(text),
      backgroundColor: color == "success"?Colors.green:color == "erro"?Color(0xFFff0c44):Colors.blue,
      behavior: SnackBarBehavior.floating, // Define o comportamento como flutuante
      margin: EdgeInsets.all(56.0)); // Define o espaço em relação à parte inferior
  }

   num total = 0;
  num correctCalc= 0;
  num incorrectCalc = 0;
  num percentage = 0;
  int approve= 0;
  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments ?? {};

    // Recupere os parâmetros
    final String results = args['results'] ?? '';
    final dynamic quiz = args['quiz'] ?? '';
    final dynamic quizDisabledArg = args['quizDisabled'] ?? '';

    if(results == 'true'){
      showQuiz = false;
      showQuiz2 = true;
      quizSelected = quiz;
      quizDisabled = quizDisabledArg;
      isDisabled = true;
      
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Visibility(
              visible: !showQuiz && !showQuiz2,
              child: Title(
                title: "Questionários",
                color: Colors.black,
                child: Text(
                  "SELECIONE O QUIZ:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFff0c44),
                  ),
                ),
              )),

          SizedBox(
              height: 16.0), // Espaçamento vertical entre o título e a lista
          Visibility(
            visible: !showQuiz && !showQuiz2,
            child: Expanded(
              flex: 0,
              child: Wrap(
                alignment:
                    WrapAlignment.start, // Alinhamento central dos itens
                spacing: 8.0, // Espaçamento horizontal entre os itens
                runSpacing:
                    0, // Espaçamento vertical entre as linhas de itens
                children: quizzes.map((quiz) {
                  bool disabled = false;
                  if(user['quiz'].length > 0){
                    user['quiz'].forEach((el) => {
                    if(disabled == false){
                      disabled = el['quiz']['title'] == quiz['title']
                    }
                  });
                  }
                
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          isDisabled = disabled;
                          title = quiz['title'];
                          dificuldade = quiz['level']['name'];
                          time = quiz['time']['hours'].toString() == '0'
                              ? 'Indeterminado'
                              : quiz['time']['hours'].toString();
                          approvalPercentage =
                              quiz['approvalPercentage'].toString();
                          questionsAmount = quiz['questionsAmount'].toString();
                          quizSelected = quiz;
                          showQuiz = true;
                              total = 0;
                              correctCalc = 0;
                              incorrectCalc = 0;
                          user['quiz'].forEach((el) => {
                              

                              if(el['quiz']['title'] == quiz['title']){
                                el['answers'].forEach((f) => {
                                  total = total + f['answers'].where((filt) => filt['value'] == true).toList().length + f['answers'].where((filt) => filt['value'] == false).toList().length,
                                  correctCalc = correctCalc + f['answers'].where((filt) => filt['value'] == true).toList().length,
                                  incorrectCalc = f['answers'].where((filt) => filt['value'] == false).toList().length
                                 }),
                                percentage = el['quiz']['approvalPercentage'],
                                approve = (correctCalc/total)*100 > percentage?1:0,
                              }
                               
                          });
                           
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.45,
                        // Largura do item (ajuste conforme necessário)
                        child: CardItem(
                          isDisabled: disabled,
                          title: quiz['title'],
                          level: quiz['level']['name'],
                          percentage: quiz['approvalPercentage'],
                          time: quiz['time']['hours'],
                          min: quiz['time']['min'],
                          height: 140,
                          width: 140,
                          unlimitedTime: quiz['unlimitedTime'],
                          questions: quiz['questionsAmount'],
                        ),
                      ));
                }).toList(),
              ),
            ),
          ),

          Visibility(
              visible: showQuiz && !showQuiz2,
              child: Column(
                children: [
                  Title(
                    title: isDisabled?"Quiz Respondido":"Iniciar quiz",
                    color: Colors.black,
                    child: Text(
                      'Infos do Quiz',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFff0c44),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width *
                          1, // Defina 90% da largura da tela
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        color: Color(0xFFff0c44),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RedCardWithInfo(
                                approve: approve,
                                correctCalc: correctCalc,
                                total:total,
                                title: title,
                                isDisabled: isDisabled,
                                tempo: time,
                                dificuldade: dificuldade,
                                questionsAmount: questionsAmount,
                                approvalPercentage: approvalPercentage,
                                onArrowPress: () => {
                                  setState((){
                                  showQuiz = false;
                                  showQuiz2 = false;
                                  })
                                  
                                },
                                callback: () async => {
                                   user = await AuthService().getUsuarioLogado(),
                                  setState(() {
                                    showQuiz = false;
                                    showQuiz2 = true;
                              user['quiz'].forEach((q) => {
                                if(q['quiz']['title']  == quizSelected['title']){
                                  
                                  quizDisabled=q
                                }
                                });
                                  })
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),

          Visibility(
            visible: !showQuiz && showQuiz2,
            child: Column(children: [
              QuizQuestion(
                  quiz: quizSelected,
                  isDisabled: isDisabled,
                  quizDisabled:quizDisabled,
                  returnQuiz: () => {
                    setState((){
                      showQuiz = true;
                      showQuiz2 = false;
                    })
                  },
                  callback: (resp) => {
                        if (resp){
                            setState(() {
                              showQuiz = false;
                              showQuiz2 = false;
                              isDisabled = false;
                               Navigator.pushNamed(context, '/home');
                            })
                          }
                      })
            ]),
          )
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final dynamic level;
  final dynamic questions;
  final dynamic percentage;
  final dynamic time;
  final dynamic min;
  final dynamic unlimitedTime;
  final double width;
  final double height;
  final bool isDisabled;

  CardItem(
    
      {required this.title,
      required this.level,
      required this.questions,
      required this.percentage,
      required this.min,
      required this.unlimitedTime,
      required this.width,
      required this.height,
      required this.isDisabled,
      required this.time,
     
      });

  @override
  Widget build(BuildContext context) {
    return 
    Opacity(
    opacity:isDisabled?0.8:1.0,
  child:
    Card(
      margin: EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0), // Margem entre os Cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Borda arredondada
      ),
      child: Container(
        height: height,
        width: width,
        
        decoration: BoxDecoration(
          color: Color(0xFFff0c44),
          
          borderRadius: BorderRadius.circular(10.0), // Borda arredondada
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
          children: [
            // Adicione sua imagem aqui com o tamanho desejado
            Image.asset(
              'quizz.png',
              height: height / 2, // Altura desejada da imagem
              width: width / 2, // Largura desejada da imagem
              fit: BoxFit.contain, // Ajusta a imagem para preencher o espaço
            ),

            // Espaçamento entre a imagem e o texto
            SizedBox(height: 4.0),

            // Texto centralizado
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    )
  );}
}

class QuizQuestion extends StatefulWidget {
  final dynamic quiz;
  final dynamic callback;
  final dynamic returnQuiz;
  final dynamic isDisabled;
  final dynamic quizDisabled;
  QuizQuestion({required this.quiz, required this.isDisabled,required this.returnQuiz,required this.quizDisabled,required this.callback,});
  @override
  _QuizQuestionState createState() => _QuizQuestionState(quiz, callback,returnQuiz,isDisabled,quizDisabled);
}

class _QuizQuestionState extends State<QuizQuestion> {
  List<int>? selectedOption = []; // Inicialmente nenhuma opção selecionada
  int? selectedQuiz = 0;
  List<dynamic> answers = [];

  final dynamic quiz; // Declaração do objeto quiz
  final dynamic callback;
  final dynamic returnQuiz;
  final dynamic isDisabled;
  final dynamic quizDisabled;
  
  _QuizQuestionState(this.quiz, this.callback,this.returnQuiz,this.isDisabled,this.quizDisabled);

  dynamic user = {};
  @override
  Widget build(BuildContext context) {
    getSnackBar(text, color) {
      return SnackBar(
          content: Text(text),
          backgroundColor: color == "success"
              ? Colors.green
              : color == "error"
                  ? Color(0xFFff0c44)
                  : Colors.blue,
          behavior: SnackBarBehavior
              .floating, // Define o comportamento como flutuante
          margin: EdgeInsets.all(
              56.0)); // Define o espaço em relação à parte inferior
    }

    final List<dynamic> options = quiz['questions'][selectedQuiz]['answers'];
    final bool multipleAnswers =
        quiz['questions'][selectedQuiz]['multipleAnswers'];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[Text(
          'Pergunta ${selectedQuiz! + 1}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFff0c44),
          ),
        ),  IconButton(
            icon: Icon(
              Icons.arrow_back, // Ícone de seta de retorno
              color: Color(0xFFff0c44)
            ),
            onPressed:() => {
              setState((){
                selectedQuiz == 0? returnQuiz():selectedQuiz = selectedQuiz!-1;
              })
            },
          ),
        ]),
        
        Card(
          margin: EdgeInsets.all(12.0),
          child: Column(
            children: [
              CardItem(
                isDisabled: false,
                title: quiz['title'],
                level: quiz['level']['name'],
                percentage: quiz['approvalPercentage'],
                time: quiz['time']['hours'],
                min: quiz['time']['min'],
                width: 230,
                height: 100,
                unlimitedTime: quiz['unlimitedTime'],
                questions: quiz['questionsAmount'],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  quiz['questions'][selectedQuiz]['question'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFff0c44),
                  ),
                ),
              ),
              Column(
                children: options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final text = entry.value;
                  dynamic ids = [];
                  dynamic idsCorrect = [];
                  if(quizDisabled['answers'] != null){
                  quizDisabled['answers'].forEach((a) => {
                    a['answers'].forEach((ans) => {
                      ids.add(ans['text'])
                    })
                  });
                  }
                  dynamic opt = ['A','B','C','D'];
                  String title = text['text'];
                  dynamic letter = opt[index];
              return RedCard(
                    text: '$letter - $title',
                    isDisabled:isDisabled,
                    isDisabledCorrect: text['value'],
                    isSelected: isDisabled?ids!.contains(text['text']):selectedOption!.contains(
                        index), // Defina isso com base na lógica do seu aplicativo
                    onSelect: (isSelected) {
                      setState(() {
                        if(isDisabled == false){
                          if (multipleAnswers) {
                              if(selectedOption!.contains(index)){
                                selectedOption!.remove(index);
                              } else {
                                selectedOption!.add(isSelected ? index : 0);
                              }
                        } else {
                          if (selectedOption!.length == 0) {
                            selectedOption!.add(isSelected ? index : 0);
                          } else {
                            selectedOption = [];
                            selectedOption!.add(isSelected ? index : 0);
                          }
                        }
                        }
                       
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedOption != []) {
              // Aqui você pode adicionar lógica para verificar a resposta e passar para a próxima pergunta
              setState(() {
                if (selectedQuiz! + 1 == quiz['questions'].length) {
                  if (selectedOption != []) {
                    var opts = [];
                    selectedOption!.forEach((opt) {
                      opts.add(quiz['questions'][selectedQuiz]['answers'][opt]);
                    });

                    Map<String, dynamic> resposta = {
                      'answer': opts,
                      'question': quiz['questions'][selectedQuiz]['question'],
                    };
                    answers.add(resposta);
                  }
                  if(isDisabled){
                      callback(true);
                  } else {
                  context.read<UserService>().salvarQuiz(
                      answers,
                      quiz,
                      (resp) => {
                            
                            if (resp){
                                callback(true),                                
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar("Quiz finalizado com sucesso!",
                                        "success"))
                              } else
                              {
                                callback(false),
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar(
                                        "Falha ao finalizar Quiz!", "error"))
                              }
                          });
                  }
                } else {
                  if (selectedOption != []) {
                    var opts = [];
                    selectedOption!.forEach((opt) {
                      opts.add(quiz['questions'][selectedQuiz]['answers'][opt]);
                    });

                    Map<String, dynamic> resposta = {
                      'answer': opts,
                      'question': quiz['questions'][selectedQuiz]['question'],
                    };
                    answers.add(resposta);
                  }
                  selectedOption = [];
                  selectedQuiz = selectedQuiz! + 1;
                }
              });
            } else {
              // Informe ao usuário para selecionar uma opção antes de continuar
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: selectedQuiz! + 1 == quiz['questions'].length
                        ? Text('Finalizar Quiz')
                        : Text('Selecione uma opção'),
                    content: Text(
                        'Por favor, escolha uma opção antes de continuar.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFff0c44), // Cor de fundo vermelha
            onPrimary: Colors.white, // Cor do texto branco
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Borda arredondada
            ),
            minimumSize: Size(
                0.9 * MediaQuery.of(context).size.width, 48), // 90% de largura
          ),
          child: Text(selectedQuiz! + 1 == quiz['questions'].length
              ? 'Finalizar Quiz'
              : 'Próxima Pergunta'),
        ),
      ],
    );
  }
}

class RedCard extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool isDisabled;
  final bool isDisabledCorrect;
  final Function(bool) onSelect;

  RedCard({
    required this.text,
    required this.isSelected,
    required this.onSelect,
    required this.isDisabled,
    required this.isDisabledCorrect
  });

  @override
  _RedCardState createState() => _RedCardState();
}

class _RedCardState extends State<RedCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.9, // Defina 90% da largura da tela
        child: Card(
          elevation: widget.isSelected ? 4.0 : 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: widget.isSelected ? 
              (widget.isDisabled && widget.isDisabledCorrect)?Colors.green :Color(0xFFff0c44) :
               (widget.isDisabled && widget.isDisabledCorrect)?Colors.green: Colors.grey,
              width: 2.0,
            ),
          ),
          color: widget.isSelected ? 
            (widget.isDisabled && widget.isDisabledCorrect)?Colors.green :Color(0xFFff0c44) :
               (widget.isDisabled && widget.isDisabledCorrect)?Colors.green: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 12.0,
                color: widget.isSelected ?  (widget.isDisabled && widget.isDisabledCorrect)?Colors.white :Colors.white :
               (widget.isDisabled && widget.isDisabledCorrect)?Colors.white: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RedCardWithInfo extends StatelessWidget {
  final String title;
  final String tempo;
  final String dificuldade;
  final String questionsAmount;
  final String approvalPercentage;
  final dynamic callback;
  final bool isDisabled;
  final num approve;
  final num total;
  final num correctCalc;
  final dynamic onArrowPress;

  RedCardWithInfo(
      {required this.title,
      required this.tempo,
      required this.dificuldade,
      required this.approvalPercentage,
      required this.questionsAmount,
      required this.isDisabled,
      required this.approve,
      required this.total,
      required this.correctCalc,
      required this.onArrowPress,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
    color: Color(0xFFff0c44),
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              'Título: $title',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0), // Espaçamento vertical
            Text(
              'Tempo: $tempo',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0), // Espaçamento vertical
            Text(
              'Dificuldade: $dificuldade',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0), // Espaçamento vertical
            Text(
              'Aprovação: $approvalPercentage%',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0), // Espaçamento vertical
            Text(
              'Questões: $questionsAmount',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ), SizedBox(height: 8.0), // Espaçamento vertical
            Text(
              isDisabled?approve == 1?'Aprovado $correctCalc/$total':'Reprovado $correctCalc/$total':'',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0), // Espaçamento vertical maior
            Center(
                child: ElevatedButton(
                  onPressed: () {
                    callback();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Color(0xFFff0c44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    isDisabled ? 'Ver Resultados' : 'Iniciar Quiz',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8.0, // Ajuste a posição vertical conforme necessário
          right: 8.0, // Ajuste a posição horizontal conforme necessário
          child: IconButton(
            icon: Icon(
              Icons.arrow_back, // Ícone de seta de retorno
              color: Colors.white,
            ),
            onPressed:() => {
              onArrowPress()
            },
          ),
        ),
      ],
    ),
  );
  }
}
