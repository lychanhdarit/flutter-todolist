import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomModelAction extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave; 
  const CustomModelAction({Key key, this.onClose, this.onSave}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
          children: <Widget>[
            Expanded(
                child: CustomBotton(
              onPressed: onClose,
              textColor: Theme.of(context).accentColor,
              buttonText: 'Close',
              color: Colors.white,
              borderColor: Theme.of(context).accentColor,
            )),
             SizedBox(
          width: 24,
        ),
            Expanded(
                child: CustomBotton(
              onPressed: onSave,
              textColor: Colors.white,
              buttonText: 'Save',
              color: Theme.of(context).accentColor, 
            )),
          ],
        );
  }
}