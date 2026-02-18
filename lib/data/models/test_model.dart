enum TestType { daily, mock, practice }

class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;
  final int marks;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
    this.marks = 1,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      explanation: json['explanation'] as String?,
      marks: json['marks'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'marks': marks,
    };
  }
}

class TestModel {
  final String id;
  final String title;
  final String description;
  final TestType type;
  final String subject;
  final String classLevel;
  final List<QuestionModel> questions;
  final int durationMinutes;
  final int totalMarks;
  final DateTime createdAt;
  final DateTime? scheduledAt;
  final bool isActive;

  TestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.subject,
    required this.classLevel,
    required this.questions,
    required this.durationMinutes,
    required this.totalMarks,
    required this.createdAt,
    this.scheduledAt,
    this.isActive = true,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: TestType.values.firstWhere(
        (e) => e.toString() == 'TestType.${json['type']}',
      ),
      subject: json['subject'] as String,
      classLevel: json['classLevel'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      durationMinutes: json['durationMinutes'] as int,
      totalMarks: json['totalMarks'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'] as String)
          : null,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'subject': subject,
      'classLevel': classLevel,
      'questions': questions.map((e) => e.toJson()).toList(),
      'durationMinutes': durationMinutes,
      'totalMarks': totalMarks,
      'createdAt': createdAt.toIso8601String(),
      'scheduledAt': scheduledAt?.toIso8601String(),
      'isActive': isActive,
    };
  }
}

class TestResultModel {
  final String id;
  final String testId;
  final String userId;
  final Map<String, int> answers; // questionId -> selectedAnswerIndex
  final int score;
  final int totalMarks;
  final int correctAnswers;
  final int wrongAnswers;
  final int unattempted;
  final DateTime completedAt;
  final int timeTakenMinutes;

  TestResultModel({
    required this.id,
    required this.testId,
    required this.userId,
    required this.answers,
    required this.score,
    required this.totalMarks,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unattempted,
    required this.completedAt,
    required this.timeTakenMinutes,
  });

  double get percentage => (score / totalMarks) * 100;

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      id: json['id'] as String,
      testId: json['testId'] as String,
      userId: json['userId'] as String,
      answers: Map<String, int>.from(json['answers'] as Map),
      score: json['score'] as int,
      totalMarks: json['totalMarks'] as int,
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      unattempted: json['unattempted'] as int,
      completedAt: DateTime.parse(json['completedAt'] as String),
      timeTakenMinutes: json['timeTakenMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testId': testId,
      'userId': userId,
      'answers': answers,
      'score': score,
      'totalMarks': totalMarks,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'unattempted': unattempted,
      'completedAt': completedAt.toIso8601String(),
      'timeTakenMinutes': timeTakenMinutes,
    };
  }
}
