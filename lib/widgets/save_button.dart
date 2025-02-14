import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class SaveButton extends StatefulWidget {
  final VoidCallback onSave;

  const SaveButton({super.key, required this.onSave});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isLoading = false;

  void _handleSave() async {
    setState(() => isLoading = true);

    await Future.delayed(Duration(milliseconds: 500)); // Simulate save process
    widget.onSave();

    if (mounted) {
      Navigator.pop(context); // Close bottom sheet immediately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwipeableButtonView(
        isFinished: false, // No unnecessary animation
        onWaitingProcess: _handleSave, // Directly call save
        activeColor: Colors.white,
        buttonColor: Colors.deepPurpleAccent,
        buttonText: isLoading ? "Saving..." : "Swipe to Save",
        buttontextstyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        buttonWidget: isLoading
            ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              )
            : const Icon(Icons.double_arrow, color: Colors.white),
        onFinish: () {},
      ),
    );
  }
}
