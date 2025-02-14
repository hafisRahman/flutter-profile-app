import 'package:flutter/material.dart';
import 'package:sample1/consts/image_path.dart';
import 'package:sample1/styles/app_colors.dart';
import 'package:sample1/widgets/custom_inputfeild.dart';
import 'package:sample1/widgets/gendr_selection_widget.dart';
import 'package:sample1/widgets/save_button.dart';
import 'package:sample1/widgets/swipe_to_save.dart';
import 'package:sample1/widgets/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isBottomSheetOpen = false;
  double childSize = 0.6; // Initially small height

  String? savedName;
  String? savedAge;
  String? savedGender;
  String? savedLocation;

  void _showBottomSheet() {
    if (!isBottomSheetOpen) {
      isBottomSheetOpen = true;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return GestureDetector(
                onTap: () {
                  setState(() => childSize = 0.95); // Expand to full screen
                },
                child: DraggableScrollableSheet(
                  initialChildSize: childSize,
                  minChildSize: 0.2,
                  maxChildSize: 0.95,
                  snapSizes: [0.6, 0.7],
                  snap: true,
                  builder: (context, scrollController) {
                    return AboutYouModal(
                      onClose: () {
                        if (mounted) {
                          setState(() => isBottomSheetOpen = false);
                          Navigator.pop(context);
                        }
                      },
                      onSave: (String name, String age, String gender,
                          String location) {
                        setState(() {
                          savedName = name;
                          savedAge = age;
                          savedGender = gender;
                          savedLocation = location;
                          isBottomSheetOpen = false;
                          childSize = 0.6; // Reset to initial height
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        });
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ).whenComplete(() {
        // Reset flag when bottom sheet is dismissed
        if (mounted) {
          setState(() {
            isBottomSheetOpen = false;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _showBottomSheet,
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < -200) {
            _showBottomSheet();
          }
        },
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.linearGradient),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(gradient: AppColors.myGradient),
                child: Center(
                  child: Image.asset(
                    avatarPng,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (savedName != null)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        normalText(text: "Name: $savedName"),
                        normalText(text: "Age: $savedAge"),
                        normalText(text: "Gender: $savedGender"),
                        normalText(text: "Location: $savedLocation"),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              GestureDetector(
                onTap: _showBottomSheet,
                child: Column(
                  children: [
                    const Icon(Icons.keyboard_arrow_up,
                        size: 40, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text("Swipe up to edit profile",
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutYouModal extends StatefulWidget {
  final VoidCallback onClose;
  final Function(
    String name,
    String age,
    String gender,
    String location,
  ) onSave;

  const AboutYouModal({super.key, required this.onClose, required this.onSave});

  @override
  State<AboutYouModal> createState() => _AboutYouModalState();
}

class _AboutYouModalState extends State<AboutYouModal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: widget.onClose,
            ),
          ),
          normalText(text: "Hey tell me about you"),
          const SizedBox(height: 10),
          Row(
            children: [
              GenderSelectionButton(
                label: 'Male',
                selectedGender: selectedGender ?? '',
                onTap: () => setState(() => selectedGender = 'Male'),
              ),
              const SizedBox(width: 10),
              GenderSelectionButton(
                label: 'Female',
                selectedGender: selectedGender ?? '',
                onTap: () => setState(() => selectedGender = 'Female'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomInputField(
              controller: nameController, hintText: 'Your good name'),
          const SizedBox(height: 10),
          CustomInputField(
              controller: ageController,
              hintText: 'How old are you?',
              keyboardType: TextInputType.number),
          const SizedBox(height: 10),
          CustomInputField(
              controller: locationController,
              hintText: 'Location',
              isSuffixIcon: true,
              svgSuffixIcon: locationIcon),
          const SizedBox(height: 20),
          SaveButton(
            onSave: () => widget.onSave(
              nameController.text,
              ageController.text,
              selectedGender ?? '',
              locationController.text,
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // SwipeToSaveButton(
          //     onSave: () => widget.onSave(
          //         nameController.text,
          //         ageController.text,
          //         selectedGender ?? '',
          //         locationController.text),
          //     onComplete: widget.onClose),
        ],
      ),
    );
  }
}
