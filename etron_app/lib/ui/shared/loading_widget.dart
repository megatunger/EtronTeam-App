import 'package:etron_app/ui/theme.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({Key key, this.description}) : super(key: key);
  final String description;
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(64.0),
        child: ClipRRect(
            borderRadius: EtronTheme.roundedBorder,
            child: Image.asset('assets/illustration/giphy.gif')),
      ),
      CircularProgressIndicator(),
      SizedBox(height: 32),
      Text('${this.widget.description}',
          style: Theme.of(context).textTheme.headline6)
    ]));
  }
}
