import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownButton2Widget extends StatelessWidget {
  final String? hintText;
  final List<Map<String, dynamic>> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const DropdownButton2Widget({
    Key? key,
    this.hintText,
    required this.items,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropdownItems = items.map((item) {
      return DropdownMenuItem<String>(
        value: item['id'].toString(),
        child: Text(
          item['name'] as String,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF09101D)),
        ),
      );
    }).toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF858C94),
        ),
      ),
      child: SizedBox(
        height: 46.0,
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            buttonPadding:
                const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF09101D),
              backgroundColor: Colors.white,
            ),
            hint: Text(
              hintText ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF09101D)),
            ),
            items: dropdownItems,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
