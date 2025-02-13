import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isSuffixIcon;
  final String? svgSuffixIcon; // SVG Icon Path
  final IconData? suffixIcon; // Normal Icon
  final TextInputType? keyboardType;

  const CustomInputField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.svgSuffixIcon, // Accepts SVG path
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        suffixIcon: isSuffixIcon
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: svgSuffixIcon != null
                    ? SvgPicture.asset(
                        svgSuffixIcon!,
                      )
                    : Icon(suffixIcon ?? Icons.visibility,
                        color: Colors.white54),
              )
            : null,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
