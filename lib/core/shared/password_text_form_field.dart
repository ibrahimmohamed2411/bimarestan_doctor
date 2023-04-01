import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.prefixIcon,
    this.initialValue,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Icon? prefixIcon;
  final String? initialValue;
  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      obscureText: hidden,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidden = !hidden;
            });
          },
          icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
