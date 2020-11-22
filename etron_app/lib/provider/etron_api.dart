import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/model/question_answer_request.dart';
import 'package:etron_app/provider/etron_api_provider.dart';
import 'package:file_picker/file_picker.dart';

class EtronApi {
  EtronApiProvider _apiProvider = EtronApiProvider();

  Future<MissingFieldsData> uploadPDF(PlatformFile platformFile) {
    return _apiProvider.uploadPDF(platformFile);
  }

  Future<void> answerQuestion(QuestionAnswerRequest request) async {
    _apiProvider.answerQuestion(request);
  }

  Future<void> done(String email) async {
    _apiProvider.done(email);
  }
}
