// import 'package:flutter/material.dart';

// class SwipeToSaveButton extends StatefulWidget {
//   final VoidCallback onSave;
//   final VoidCallback onComplete; // New callback to close BottomSheet

//   const SwipeToSaveButton({
//     super.key,
//     required this.onSave,
//     required this.onComplete,
//   });

//   @override
//   _SwipeToSaveButtonState createState() => _SwipeToSaveButtonState();
// }

// class _SwipeToSaveButtonState extends State<SwipeToSaveButton> {
//   double dragPosition = 0.0;
//   bool isSaved = false;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double buttonWidth = constraints.maxWidth;
//         double dragMax = buttonWidth - 60; // Maximum drag range

//         return Center(
//           child: Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               // Background Button (White Field)
//               Container(
//                 width: buttonWidth,
//                 height: 55,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(35),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(horizontal: 75),
//                 child: Text(
//                   isSaved ? "Saved!" : "Let's save and roll!",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),

//               // Draggable Button (Purple)
//               Positioned(
//                 left: dragPosition,
//                 child: GestureDetector(
//                   onHorizontalDragUpdate: (details) {
//                     setState(() {
//                       dragPosition += details.delta.dx;
//                       dragPosition = dragPosition.clamp(0, dragMax);
//                     });
//                   },
//                   onHorizontalDragEnd: (details) {
//                     if (dragPosition > dragMax * 0.8) {
//                       // Trigger save if dragged enough
//                       setState(() {
//                         isSaved = true;
//                         dragPosition = dragMax;
//                       });
//                       widget.onSave();
//                     } else {
//                       // Reset position if not fully dragged
//                       setState(() {
//                         dragPosition = 0;
//                       });
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 7),
//                     child: Container(
//                       width: 45,
//                       height: 45,
//                       decoration: const BoxDecoration(
//                         color: Colors.deepPurpleAccent,
//                         shape: BoxShape.circle,
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: const Icon(Icons.double_arrow,
//                           color: Colors.white, size: 28),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class SwipeToSaveButton extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onComplete;

  const SwipeToSaveButton({
    super.key,
    required this.onSave,
    required this.onComplete,
  });

  @override
  _SwipeToSaveButtonState createState() => _SwipeToSaveButtonState();
}

class _SwipeToSaveButtonState extends State<SwipeToSaveButton> {
  double dragPosition = 0.0;
  bool isSaved = false;
  double scale = 1.0; // Default scale for animation

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonWidth = constraints.maxWidth;
        double dragMax = buttonWidth - 60; // Maximum drag range

        return Center(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Background Button (White Field)
              Container(
                width: buttonWidth,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: Text(
                  isSaved ? "Saved!" : "Let's save and roll!",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              // Draggable Button (Purple)
              Positioned(
                left: dragPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      dragPosition += details.delta.dx;
                      dragPosition = dragPosition.clamp(0, dragMax);
                      scale = 1.1; // Scale up when dragging
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (dragPosition > dragMax * 0.8) {
                      // Trigger save if dragged enough
                      setState(() {
                        isSaved = true;
                        dragPosition = dragMax;
                      });
                      widget.onSave();
                    } else {
                      // Reset position smoothly if not fully dragged
                      setState(() {
                        scale = 1.0;
                      });
                      Future.delayed(const Duration(milliseconds: 200), () {
                        setState(() {
                          dragPosition = 0;
                        });
                      });
                    }
                  },
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 200),
                    tween: Tween<double>(begin: 1.0, end: scale),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.double_arrow,
                            color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
