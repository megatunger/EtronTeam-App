import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/ui/pending_questions/camera_view.dart';
import 'package:etron_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_speech/google_speech.dart';
import 'package:sound_stream/sound_stream.dart';

class QuestionRecorder extends StatefulWidget {
  QuestionRecorder({Key key, this.missingFields}) : super(key: key);
  final MissingFieldsData missingFields;

  @override
  _QuestionRecorderState createState() => _QuestionRecorderState();
}

class _QuestionRecorderState extends State<QuestionRecorder> {
  ServiceAccount serviceAccount;
  SpeechToText speechToText;
  RecorderStream _recorder = RecorderStream();

  final streamingConfig = StreamingRecognitionConfig(
      config: RecognitionConfig(
          encoding: AudioEncoding.LINEAR16,
          model: RecognitionModel.basic,
          enableAutomaticPunctuation: true,
          sampleRateHertz: 16000,
          languageCode: 'vi-VN'),
      interimResults: true);

  @override
  void initState() {
    // loadAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: EtronTheme.elevation,
          backgroundColor: EtronTheme.primaryColor,
        ),
        body: CameraView());
  }

  loadAccount() async {
    serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/careerplannerapi-1603532127051-2390496eadbe.json'))}');
    speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    _recorder.initialize();
    _recorder.start().then((value) {
      final responseStream = speechToText.streamingRecognize(
          streamingConfig, _recorder.audioStream);
      responseStream.listen((data) {
        print(data.results[0].alternatives[0].transcript);
      });
    });
  }

  @override
  void dispose() {
    _recorder.stop();
    _recorder.dispose();
    super.dispose();
  }
}
