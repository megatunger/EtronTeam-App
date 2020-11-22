import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/provider/etron_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rxdart/rxdart.dart';

class EtronBloc {
  final EtronApi _api = EtronApi();
  final BehaviorSubject<MissingFieldsData> _missingFieldsSubject =
      BehaviorSubject<MissingFieldsData>();

  uploadPDF(PlatformFile platformFile) async {
    MissingFieldsData response = await _api.uploadPDF(platformFile);
    _missingFieldsSubject.sink.add(response);
  }

  dispose() {
    _missingFieldsSubject.close();
  }

  BehaviorSubject<MissingFieldsData> get missingFieldsSubject =>
      _missingFieldsSubject;
}

final etronBloc = EtronBloc();
