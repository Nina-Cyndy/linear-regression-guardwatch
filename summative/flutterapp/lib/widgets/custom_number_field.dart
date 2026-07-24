import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomNumberField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,

        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],

        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
