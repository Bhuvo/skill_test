
class TestModel{
  String? title;
  String? description;
  List<String>? instruction;
  String? videoUrl;
  List<QuestionModel>? questions;
  TestModel({this.title,this.description,this.instruction,this.videoUrl,this.questions});

  static TestModel fromJson(Map<String, dynamic> json) {
    return TestModel(
      title: json['title'],
      description: json['description'],
      instruction: (json['instruction'] as List<dynamic>?)?.map((e) => e.toString()).toList(), // Explicitly casting
      videoUrl: json['video_url'],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((question) => QuestionModel.fromJson(question))
          .toList(),
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['instruction'] = this.instruction;
    data['video_url'] = this.videoUrl;
    data['questions'] = this.questions?.map((question) => question.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return '$title';
  }
}


class QuestionModel {
  final int start;
  final List<Option> options;
  final int timePause;
  final String text;

  QuestionModel({
    required this.start,
    required this.options,
    required this.timePause,
    required this.text,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      start: json['start'],
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
      timePause: json['pause'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'options': options.map((option) => option.toJson()).toList(),
      'pause': timePause,
      'text': text,
    };
  }
}

class Option {
  final String answer;
  final int score;

  Option({required this.answer, required this.score});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      answer: json['answer'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'score': score,
    };
  }

  @override
  toString() {
    return '$answer';
  }
}
