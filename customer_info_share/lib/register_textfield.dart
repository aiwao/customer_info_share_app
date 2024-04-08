import 'package:flutter/material.dart';

class RegisterTextField extends StatefulWidget {
  final String fieldName;
  final String labelText;
  String strVal = '';
  int intVal = 0;

  final TextEditingController _controller = TextEditingController();

  RegisterTextField(this.fieldName, this.labelText, {Key? key}) : super(key: key);

  void clear() {
    debugPrint('RegisterTextField.clear');
    _controller.clear();
    strVal = '';
    intVal = 0;
  }

  @override
  RegisterTextFieldState createState() => RegisterTextFieldState();
}

class RegisterTextFieldState extends State<RegisterTextField> {

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        debugPrint('onChanged : $text');
        widget.strVal = text;
        try {
          widget.intVal = int.parse(text);
        }
        catch(e) {
          widget.intVal = 0;
        }
        debugPrint('strVal: ${widget.strVal}');
        debugPrint('intVal: ${widget.intVal}');
      },
    );
  }
}