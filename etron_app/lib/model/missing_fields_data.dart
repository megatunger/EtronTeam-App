// To parse this JSON data, do
//
//     final missingFieldsData = missingFieldsDataFromJson(jsonString);

import 'dart:convert';

MissingFieldsData missingFieldsDataFromJson(String str) =>
    MissingFieldsData.fromJson(json.decode(str));

String missingFieldsDataToJson(MissingFieldsData data) =>
    json.encode(data.toJson());

class MissingFieldsData {
  MissingFieldsData({
    this.email,
    this.missingFields,
  });

  String email;
  List<MissingField> missingFields;

  factory MissingFieldsData.fromJson(Map<String, dynamic> json) =>
      MissingFieldsData(
        email: json["email"] == null ? null : json["email"],
        missingFields: json["missing_fields"] == null
            ? null
            : List<MissingField>.from(
                json["missing_fields"].map((x) => MissingField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "missing_fields": missingFields == null
            ? null
            : List<dynamic>.from(missingFields.map((x) => x.toJson())),
      };
}

class MissingField {
  MissingField({
    this.field,
    this.question,
  });

  String field;
  String question;

  factory MissingField.fromJson(Map<String, dynamic> json) => MissingField(
        field: json["field"] == null ? null : json["field"],
        question: json["question"] == null ? null : json["question"],
      );

  Map<String, dynamic> toJson() => {
        "field": field == null ? null : field,
        "question": question == null ? null : question,
      };
}
