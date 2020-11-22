import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/ui/pending_questions/question_recorder.dart';
import 'package:etron_app/ui/theme.dart';
import 'package:flutter/material.dart';

class StartInterviewWidget extends StatefulWidget {
  StartInterviewWidget({Key key, this.missingFields}) : super(key: key);
  final MissingFieldsData missingFields;

  @override
  _StartInterviewWidgetState createState() => _StartInterviewWidgetState();
}

class _StartInterviewWidgetState extends State<StartInterviewWidget> {
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: EtronTheme.elevation,
        backgroundColor: EtronTheme.primaryColor,
      ),
      body: Center(
          child: CircularCountDownTimer(
        duration: 3,
        controller: _controller,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.white,
        fillColor: EtronTheme.primaryColor,
        backgroundColor: null,
        strokeWidth: 5.0,
        textStyle: TextStyle(
            fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: true,
        onComplete: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    QuestionRecorder(missingFields: this.widget.missingFields)),
          );
        },
      )),
    );
  }
}
