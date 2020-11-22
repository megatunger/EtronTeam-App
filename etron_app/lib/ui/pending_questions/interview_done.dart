import 'package:animate_do/animate_do.dart';
import 'package:etron_app/ui/theme.dart';
import 'package:flutter/material.dart';

class InterviewDone extends StatefulWidget {
  InterviewDone({Key key}) : super(key: key);

  @override
  _InterviewDoneState createState() => _InterviewDoneState();
}

class _InterviewDoneState extends State<InterviewDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: EtronTheme.elevation,
          backgroundColor: EtronTheme.primaryColor,
          title: Text('Đã xong rồi!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: ElasticIn(
                  delay: Duration(milliseconds: 500),
                  child: Pulse(
                      delay: Duration(milliseconds: 800),
                      duration: Duration(seconds: 3),
                      child: Image.asset('assets/illustration/urban-199.png'),
                      infinite: true),
                ),
              ),
              SizedBox(height: 16),
              FadeIn(
                delay: Duration(milliseconds: 700),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('Cảm ơn bạn đã tham gia buổi phỏng vấn nho nhỏ!',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ));
  }
}
