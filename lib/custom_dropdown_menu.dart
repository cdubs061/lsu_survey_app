import 'package:flutter/material.dart';

//DropdownMenu Class
class CustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String value;
  final Function(String?) onChanged ;
  final String labelText;

  const CustomDropdownMenu({super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,  // Handle empty string as null for Dropdown
      onChanged: onChanged,
      items: [
        const DropdownMenuItem<String>(
          value: '',  // Empty string for the blank option
          child: Text('Select an option'),
        ),
        ...items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ],
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}