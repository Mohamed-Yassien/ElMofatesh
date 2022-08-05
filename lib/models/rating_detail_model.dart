class RatingDetailModel {
  int? id;
  String? userId;
  String? title;
  String? detail;
  String? category;
  String? date;
  List<Questions>? questions;


  RatingDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    detail = json['detail'];
    category = json['category'];
    date = json['date'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add( Questions.fromJson(v));
      });
    }
  }

}

class Questions {
  int? id;
  String? question;
  String? answerType;
  String? operationId;
  List<Answers>? answers;


  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answerType = json['answerType'];
    operationId = json['operation_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add( Answers.fromJson(v));
      });
    }
  }
}

class Answers {
  int? value;
  String? label;

  Answers({this.value, this.label});

  Answers.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    return data;
  }
}
