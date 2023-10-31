class Quiz {
  final DateTime? created;
  final String? type;
  final String? query;
  final String? toDelete;
  final String? instructions;
  final int approvalPercentage;
  final bool unlimitedTime;
  final List<String?> subjects;
  final String? title;
  final Time? time;
  final Map<String, int> userAttempts;
  final String? uuid;
  final List<Question>? questions;
  final int? questionsAmount;
  final String? userId;
  final Level? level;
  final List<String>? questionsNames;
  final DateTime? updated;

  Quiz({
    required this.created,
    required this.type,
    required this.query,
    required this.toDelete,
    required this.instructions,
    required this.approvalPercentage,
    required this.unlimitedTime,
    required this.subjects,
    required this.title,
    required this.time,
    required this.userAttempts,
    required this.uuid,
    required this.questions,
    required this.questionsAmount,
    required this.userId,
    required this.level,
    required this.questionsNames,
    required this.updated,
  });

  factory Quiz.fromMap(Map<String, dynamic> json) {
    final List<dynamic> rawQuestions = json['questions'] ?? [];
    final List<Question> parsedQuestions = rawQuestions
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();

    return Quiz(
      created: DateTime.parse(json['created']),
      type: json['type'],
      query: json['query'],
      toDelete: json['toDelete'],
      instructions: json['instructions'],
      approvalPercentage: json['approvalPercentage'],
      unlimitedTime: json['unlimitedTime'],
      subjects: List<String>.from(json['subjects'] ?? []),
      title: json['title'],
      time: Time.fromJson(json['time']),
      userAttempts: Map<String, int>.from(json['userAttempts'] ?? {}),
      uuid: json['uuid'],
      questions: parsedQuestions,
      questionsAmount: json['questionsAmount'],
      userId: json['userId'],
      level: Level.fromJson(json['level']),
      questionsNames: List<String>.from(json['questionsNames'] ?? []),
      updated: DateTime.parse(json['updated']),
    );
  }
}

class Time {
  final int hours;
  final int seconds;
  final int minutes;

  Time({
    required this.hours,
    required this.seconds,
    required this.minutes,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      hours: json['hours'],
      seconds: json['seconds'],
      minutes: json['minutes'],
    );
  }
}

class Question {
  final String? toDelete;
  final String image;
  final String question;
  final Level level;
  final DateTime created;
  final String subject;
  final List<Answer> answers;
  final String answerJustification;
  final bool multipleAnswers;
  final String answerJustificationSource;
  final String name;
  final String id;
  final String imageSize;
  final DateTime updated;

  Question({
    required this.toDelete,
    required this.image,
    required this.question,
    required this.level,
    required this.created,
    required this.subject,
    required this.answers,
    required this.answerJustification,
    required this.multipleAnswers,
    required this.answerJustificationSource,
    required this.name,
    required this.id,
    required this.imageSize,
    required this.updated,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawAnswers = json['answers'] ?? [];
    final List<Answer> parsedAnswers =
        rawAnswers.map((answerJson) => Answer.fromJson(answerJson)).toList();

    return Question(
      toDelete: json['toDelete'],
      image: json['image'],
      question: json['question'],
      level: Level.fromJson(json['level']),
      created: DateTime.parse(json['created']),
      subject: json['subject'],
      answers: parsedAnswers,
      answerJustification: json['answerJustification'],
      multipleAnswers: json['multipleAnswers'],
      answerJustificationSource: json['answerJustificationSource'],
      name: json['name'],
      id: json['id'],
      imageSize: json['imageSize'],
      updated: DateTime.parse(json['updated']),
    );
  }
}

class Answer {
  final String description;
  final String ansId;
  final String text;
  final bool value;

  Answer({
    required this.description,
    required this.ansId,
    required this.text,
    required this.value,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      description: json['description'],
      ansId: json['ansId'],
      text: json['text'],
      value: json['value'],
    );
  }
}

class Level {
  final String name;
  final int index;

  Level({
    required this.name,
    required this.index,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      name: json['name'],
      index: json['index'],
    );
  }
}
