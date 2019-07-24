import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String value;

  const CustomDateTimePicker({Key key, this.onPressed, this.icon, this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Theme.of(context).accentColor,
              size: 30,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              value,
              style:
                  TextStyle(fontSize: 14, color: Theme.of(context).accentColor),
            )
          ],
        ),
      ),
    );
  }
}
