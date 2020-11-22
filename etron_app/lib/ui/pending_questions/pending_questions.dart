import 'dart:io';

import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/ui/components/primary_button.dart';
import 'package:etron_app/ui/pending_questions/start_interview_widget.dart';
import 'package:etron_app/ui/shared/permission_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PendingQuestions extends StatefulWidget {
  PendingQuestions({Key key, this.missingFields}) : super(key: key);
  final MissingFieldsData missingFields;
  @override
  _PendingQuestionsState createState() => _PendingQuestionsState();
}

class _PendingQuestionsState extends State<PendingQuestions> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Image.asset('assets/illustration/urban-686.png'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Chúng tôi cần biết những thông tin khác, bạn sẵn sàng cho một buổi phỏng vấn nho nhỏ chứ?',
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(),
        Center(
          child: Column(
              children: Permission.values
                  .where((Permission permission) {
                    if (Platform.isIOS) {
                      return permission == Permission.camera ||
                          permission == Permission.microphone;
                    } else {
                      return permission == Permission.camera ||
                          permission == Permission.speech;
                    }
                  })
                  .map((permission) => PermissionWidget(permission))
                  .toList()),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
              title: 'Bắt đầu phỏng vấn',
              icon: Icons.video_call_rounded,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StartInterviewWidget(
                          missingFields: this.widget.missingFields)),
                );
              }),
        ),
        SizedBox(height: 32)
      ]),
    );
  }
}
