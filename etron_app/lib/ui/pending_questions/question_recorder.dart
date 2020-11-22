import 'package:animate_do/animate_do.dart';
import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/ui/components/primary_button.dart';
import 'package:etron_app/ui/pending_questions/camera_view.dart';
import 'package:etron_app/ui/pending_questions/interview_done.dart';
import 'package:etron_app/ui/pending_questions/modal_question.dart';
import 'package:etron_app/ui/pending_questions/start_interview_widget.dart';
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
  var recognizedText = '';

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
    loadAccount();
    Future.delayed(Duration(milliseconds: 800), () {
      showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: EtronTheme.roundedBorder),
        builder: (BuildContext context) {
          return Container(
              height: 300,
              child: ModalQuestion(
                missingField: this.widget.missingFields.missingFields[0],
              ));
        },
      );
    });
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flash(
                  child: Icon(Icons.video_call_rounded,
                      size: 64, color: Colors.red),
                  infinite: true,
                  duration: Duration(seconds: 1)),
            ),
            CameraView(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('$recognizedText',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                  title: 'Đã trả lời xong câu hỏi này',
                  icon: Icons.cloud_upload_rounded,
                  callback: () {
                    var _nextData = this.widget.missingFields;
                    if (_nextData.missingFields.length != 1) {
                      _nextData.missingFields.removeAt(0);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StartInterviewWidget(missingFields: _nextData)),
                      );
                    } else {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InterviewDone()),
                      );
                    }
                  }),
            ),
            SizedBox(height: 32)
          ],
        ));
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
        print(data);
        setState(() {
          recognizedText = data.results[0].alternatives[0].transcript;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
