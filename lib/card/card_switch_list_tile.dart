import 'package:flutter/material.dart';

class CardSwitchListTile extends StatelessWidget {
  final bool isActive;
  final String? title;
  final Function(bool)? onChanged;

  const CardSwitchListTile({
    Key? key,
    required this.isActive,
    required this.title,
    required this.onChanged,
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 10,
      child: SwitchListTile(
        title: Text(title!),
        value: isActive,
        onChanged: onChanged, 
        ),
    );
  }
  
}