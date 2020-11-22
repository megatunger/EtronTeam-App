import 'package:etron_app/ui/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final IconData icon;

  const PrimaryButton({Key key, this.callback, this.title, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 64,
        child: RaisedButton.icon(
          elevation: EtronTheme.elevation,
          color: EtronTheme.primaryColor,
          icon: Icon(icon, size: 32),
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: EtronTheme.roundedBorder,
          ),
          label: Text('$title', style: TextStyle(fontSize: 16)),
          onPressed: callback,
        ));
  }
}
