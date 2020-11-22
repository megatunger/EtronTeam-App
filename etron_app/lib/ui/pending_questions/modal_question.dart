import 'package:etron_app/model/missing_fields_data.dart';
import 'package:flutter/material.dart';

class ModalQuestion extends StatefulWidget {
  ModalQuestion({Key key, this.missingField}) : super(key: key);
  final MissingField missingField;
  @override
  _ModalQuestionState createState() => _ModalQuestionState();
}

class _ModalQuestionState extends State<ModalQuestion> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    }); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.help, size: 64),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${this.widget.missingField.question}',
                style: Theme.of(context).textTheme.headline5),
          ),
        ],
      ),
    );
  }
}
