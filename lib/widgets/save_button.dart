import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class SaveButton extends StatefulWidget {
  final VoidCallback onSave;

  const SaveButton({super.key, required this.onSave});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isFinished = false;
  bool isLoading = false;
  double scale = 1.0; // For smooth scaling animation

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(scale), // Scale animation
        child: SwipeableButtonView(
          isFinished: isFinished,
          onFinish: () async {
            setState(() {
              isFinished = false;
              isLoading = false;
              scale = 1.0; // Reset scale
            });
          },
          onWaitingProcess: () async {
            setState(() => scale = 0.9); // Shrink button slightly
            await Future.delayed(Duration(milliseconds: 200));

            setState(() => isLoading = true); // Show loader
            await Future.delayed(
                Duration(milliseconds: 200)); // Simulate save process
            widget.onSave();

            setState(() {
              isFinished = true;
              isLoading = false;
              scale = 1.0; // Restore scale
            });

            await Future.delayed(Duration(seconds: 1));
            setState(() => isFinished = false);
          },
          activeColor: Colors.white,
          buttonText: isLoading ? "saving..." : "Let's save and roll!",
          buttontextstyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          buttonWidget: isLoading
              ? const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                    strokeWidth: 3,
                  ),
                )
              : const Icon(Icons.double_arrow, color: Colors.white),
          buttonColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
