import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';

class PrettyFuzzyButton extends StatefulWidget {
  const PrettyFuzzyButton({
    super.key,
    required this.label,
    required this.foregroundColor,
  });
  final String label;
  final Color foregroundColor;
  @override
  State<PrettyFuzzyButton> createState() => _PrettyFuzzyButtonState();
}

class _PrettyFuzzyButtonState extends State<PrettyFuzzyButton> {
  final double radius = s10;
  final double sideRadius = s5;
  bool _isHovered = false;
  bool _isPressed = false;
  final Color secondaryColor = const Color(0xff692ADF);
  final Color originalColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(s50),
          color: _isHovered ? secondaryColor : originalColor,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: secondaryColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: s14,
          horizontal: s42,
        ),
        margin: EdgeInsets.only(bottom: radius),
        child: Text(
          widget.label,
          style: TextStyle(
            letterSpacing: _isHovered ? s2 : s1,
            color: widget.foregroundColor,
          ),
        ),
      ),
    );
  }
}
