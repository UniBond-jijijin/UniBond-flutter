import 'package:flutter/material.dart';
import 'package:unibond/resources/app_colors.dart';

class SelectableContainer extends StatefulWidget {
  final String text;
  final Function(bool isSelected) onSelected;
  final bool isSelected;

  const SelectableContainer({
    required this.text,
    required this.onSelected,
    this.isSelected = false,
    super.key,
  });

  @override
  State<SelectableContainer> createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onSelected(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: toggleSelection,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey,
              width: 1,
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[800],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
