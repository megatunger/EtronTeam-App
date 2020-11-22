import 'package:animate_do/animate_do.dart';
import 'package:etron_app/ui/components/primary_button.dart';
import 'package:etron_app/ui/uploaded_cv/uploaded_c_v.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OnboardWidget extends StatefulWidget {
  OnboardWidget({Key key}) : super(key: key);

  @override
  _OnboardWidgetState createState() => _OnboardWidgetState();
}

class _OnboardWidgetState extends State<OnboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: ElasticIn(
                delay: Duration(milliseconds: 500),
                child: Pulse(
                    delay: Duration(milliseconds: 800),
                    duration: Duration(seconds: 3),
                    child: Image.asset('assets/illustration/urban-409.png'),
                    infinite: true),
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: 700),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('Hãy gửi CV của bạn để chúng tôi phân tích nhé!',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center),
              ),
            ),
            Spacer(),
            FadeInUp(
              delay: Duration(milliseconds: 500),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Lưu ý hệ thống chỉ chấp nhận định dạng PDF.',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center),
                      SizedBox(height: 24),
                      PrimaryButton(
                          title: 'Nộp CV',
                          icon: Icons.cloud_upload_rounded,
                          callback: () {
                            openPicker();
                          }),
                    ],
                  )),
            ),
            SizedBox(height: 32)
          ]),
    ));
  }

  openPicker() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadedCV(
                  platformFile: file,
                )),
      );
    } else {
      // User canceled the picker
    }
  }
}
