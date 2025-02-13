import 'package:flutter/material.dart';

class GenderSelectionButton extends StatelessWidget {
  final String label;
  final String selectedGender;
  final VoidCallback onTap;

  const GenderSelectionButton({
    super.key,
    required this.label,
    required this.selectedGender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedGender == label;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurpleAccent : Colors.white10,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white54, width: 0.5),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
