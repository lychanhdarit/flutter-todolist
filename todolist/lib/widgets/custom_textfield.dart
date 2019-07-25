import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const CustomTextField({Key key, this.labelText, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return TextField(
      controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: labelText, 
                prefixIcon: const Icon(Icons.edit, color: Colors.red,),
                    prefixText: ' ', 
          )
    );
  }
}