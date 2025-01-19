// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../util/app_color.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final Function(String?)? validator; // Validator function to be used for input validation

  final EdgeInsetsGeometry margin;
  final String label;
  final bool isObscure;
  final TextEditingController controller;
  final bool disabled;
  final bool obscureText;
  final Color backgroundColor;
  final bool requiredField;
  final TextInputType? keyboardType;
  final Color hintColor;
  final Icon icno;

  const CustomInput({
    Key? key,
    this.disabled = false,
    this.validator,
    required this.label,
    required this.icno,
    required this.requiredField,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.hint,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.obscureText = false,
    this.isObscure = false,
    this.backgroundColor = Colors.transparent,
    this.hintColor = AppColor.primary,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: TextFormField(
          validator: (value) {
            if (widget.requiredField && (value == null || value.isEmpty)) {
              return 'Required Field'; // Default error message for required field
            }
            if (widget.validator != null) {
              return widget.validator!(value); // Use the provided validator function
            }
            return null;
          },
          keyboardType: widget.keyboardType,
          readOnly: widget.disabled,
          obscureText: widget.obscureText && !isPasswordVisible,
          style: const TextStyle(fontSize: 16),
          maxLines: 1,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColor.blackColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : widget.icno,
            label: Text(
              widget.label,
              style: TextStyle(fontSize: 16, color: AppColor.blackColor),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 16, color: AppColor.secondarySoft),
          ),
        ),
      ),
    );
  }
}