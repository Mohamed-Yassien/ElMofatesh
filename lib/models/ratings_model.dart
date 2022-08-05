class RatingsModel {
  bool? status;
  List<Data>? data;

  RatingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach(
        (v) {
          data!.add(Data.fromJson(v));
        },
      );
    }
  }
}

class Data {
  int? id;
  String? title;
  String? detail;
  int? answersCount;
  String? category;
  String? date;
  List<Questions>? questions;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    answersCount = json['answers_count'];
    category = json['category'];
    date = json['date'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach(
        (v) {
          questions!.add(Questions.fromJson(v));
        },
      );
    }
  }
}

class Questions {
  int? id;
  String? userId;
  String? operationId;
  String? question;
  String? answerType;
  List<Answers>? answers;

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    operationId = json['operation_id'];
    question = json['question'];
    answerType = json['answerType'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    return data;
  }
}
