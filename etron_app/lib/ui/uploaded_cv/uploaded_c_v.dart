import 'package:etron_app/bloc/etron_bloc.dart';
import 'package:etron_app/model/missing_fields_data.dart';
import 'package:etron_app/ui/pending_questions/pending_questions.dart';
import 'package:etron_app/ui/shared/loading_widget.dart';
import 'package:etron_app/ui/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadedCV extends StatefulWidget {
  UploadedCV({Key key, this.platformFile}) : super(key: key);
  final PlatformFile platformFile;

  @override
  _UploadedCVState createState() => _UploadedCVState();
}

class _UploadedCVState extends State<UploadedCV> {
  @override
  void initState() {
    etronBloc.uploadPDF(this.widget.platformFile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: EtronTheme.elevation,
          backgroundColor: EtronTheme.primaryColor,
        ),
        body: StreamBuilder(
          stream: etronBloc.missingFieldsSubject.stream,
          builder: (BuildContext context,
              AsyncSnapshot<MissingFieldsData> snapshot) {
            Widget _widget;
            if (snapshot.hasData) {
              _widget = PendingQuestions(missingFields: snapshot.data);
            } else if (snapshot.hasError) {
              _widget = LoadingWidget(
                  description: 'Có lỗi xảy ra: ${snapshot.error.toString()}');
            } else {
              _widget =
                  LoadingWidget(description: 'Hệ thống đang xử lí CV của bạn');
            }
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOutQuad,
                switchOutCurve: Curves.easeInOutQuad,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: _widget);
          },
        ));
  }

  @override
  void dispose() {
    etronBloc.missingFieldsSubject.sink.add(null);
    super.dispose();
  }
}
