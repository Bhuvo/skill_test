
import 'package:flutter/material.dart';

class MDropDown extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemChanged;
 const MDropDown({super.key , required this.items, required this.onItemChanged,});

  @override
  _MDropDownState createState() => _MDropDownState();
}

class _MDropDownState extends State<MDropDown> {
  String? selectedValue ;

  List<String> dropdownItems = ["Option 1", "Option 2", "Option 3", "Option 4"];

  @override
  void initState() {
   dropdownItems = widget.items;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text("Select an option"),
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
        widget.onItemChanged.call(newValue ?? '');
          setState(() {
            selectedValue = newValue;
          });
        },
      ),
    );
  }
}