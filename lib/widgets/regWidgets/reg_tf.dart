import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegTextField extends StatelessWidget {
  const RegTextField({Key? key, required this.textCtrl, required this.icon, required this.hint, this.isSecured = false, this.inputType = TextInputType.text, this.maxLines = 1}) : super(key: key);

  final TextEditingController textCtrl;
  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final bool? isSecured;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: textCtrl,
        textAlign: TextAlign.right,
        keyboardType: inputType!,
        obscureText: isSecured!,
        maxLines: maxLines!,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12 ),
        ),
      ),
    );
  }
}
