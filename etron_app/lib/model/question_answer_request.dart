// To parse this JSON data, do
//
//     final questionAnswerRequest = questionAnswerRequestFromJson(jsonString);

import 'dart:convert';

QuestionAnswerRequest questionAnswerRequestFromJson(String str) =>
    QuestionAnswerRequest.fromJson(json.decode(str));

String questionAnswerRequestToJson(QuestionAnswerRequest data) =>
    json.encode(data.toJson());

class QuestionAnswerRequest {
  QuestionAnswerRequest({
    this.email,
    this.field,
    this.answer,
  });

  String email;
  String field;
  String answer;

  factory QuestionAnswerRequest.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerRequest(
        email: json["email"] == null ? null : json["email"],
        field: json["field"] == null ? null : json["field"],
        answer: json["answer"] == null ? null : json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "field": field == null ? null : field,
        "answer": answer == null ? null : answer,
      };
}
