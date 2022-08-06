class SaveDataInRatingQuestionsModel {
  int? id;
  int? unitId;
  int? userId;
  int? companyId;
  List<SaveQuestions>? questions;

  SaveDataInRatingQuestionsModel(
      {required this.id,
      required this.unitId,
      required this.userId,
      required this.companyId,
      required this.questions});

  SaveDataInRatingQuestionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unit_id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    if (json['questions'] != null) {
      questions = <SaveQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(SaveQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_id'] = unitId;
    data['user_id'] = userId;
    data['company_id'] = companyId;

    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaveQuestions {
  int? id;
  String? question;
  String? answerType;
  String? image;
  int? operationId;
  dynamic notes;
  dynamic choose;

  SaveQuestions({
    this.id,
    this.question,
    this.answerType,
    this.image,
    this.operationId,
    this.notes,
    this.choose,
  });

  SaveQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answerType = json['answerType'];
    image = json['image'];
    operationId = json['operation_id'];
    notes = json['notes'];
    choose = json['choose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answerType'] = answerType;
    data['image'] = image;
    data['operation_id'] = operationId;
    data['notes'] = notes;
    data['choose'] = choose;
    return data;
  }
}
