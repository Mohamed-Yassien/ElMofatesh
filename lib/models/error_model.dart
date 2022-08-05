class ErrorModel {
  bool? success;
  String? message;


  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }


}
