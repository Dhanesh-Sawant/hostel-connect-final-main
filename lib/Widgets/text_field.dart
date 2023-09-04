import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class InputTextField extends StatelessWidget {

  const InputTextField({
    Key? key,
    required this.hintText,
    this.isPass = false,
    required this.textinputType,
    required this.textEditingController
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final bool isPass;
  final TextInputType textinputType;

  @override
  Widget build(BuildContext context) {

    final inputborder = OutlineInputBorder(
        borderSide: BorderSide(
          color: purplemaincolor,
          width: 2
        ),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(

        fillColor: Colors.transparent.withOpacity(0.3),
        hintText: hintText,
        border: inputborder,
        enabledBorder: inputborder,
        focusedBorder: inputborder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      obscureText: isPass,
      keyboardType: textinputType,
    );
  }
}
