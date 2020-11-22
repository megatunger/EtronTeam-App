import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/model/question_answer_request.dart';
import 'package:etron_app/util/constant.dart';
import 'package:file_picker/file_picker.dart';

class EtronApiProvider {
  final Dio _dio = Dio();

  Future<MissingFieldsData> uploadPDF(PlatformFile platformFile) async {
    final _endpoint = Constant.endpoint + '/pdf';
    final File myFile = File(platformFile.path);
    String fileName = myFile.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        myFile.path,
        filename: fileName,
      ),
    });
    try {
      Response response = await _dio.post(_endpoint, data: data);
      return MissingFieldsData.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MissingFieldsData();
    }
  }

  Future<void> answerQuestion(QuestionAnswerRequest request) async {
    final _endpoint = Constant.endpoint + '/question';
    try {
      await _dio.post(_endpoint, data: request.toJson());
      return;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return;
    }
  }

  Future<void> done(String email) async {
    final _endpoint = Constant.endpoint + '/processing';
    try {
      await _dio.post(_endpoint, data: {email: email});
      return;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return;
    }
  }
}
