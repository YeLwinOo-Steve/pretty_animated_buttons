import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';

/// Neumorphic style button
/// When using neumorphic button, to feel neumorphic effect,
/// you'll have to change the color surrounding the neumorphic button other than white
/// ⚠️Don't use white color or you'll see wierd effect
/// I suggest using light or medium grey colors like [Colors.grey.shade100],[Colors.grey.shade200],[Colors.grey.shade300],etc
class PrettyNeumorphicButton extends StatefulWidget {
  const PrettyNeumorphicButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
    this.padding,
    this.duration,
    this.borderRadius,
  });
  final String label;
  final VoidCallback onPressed;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final Duration? duration;
  final double? borderRadius;
  @override
  State<PrettyNeumorphicButton> createState() => _PrettyNeumorphicButtonState();
}

class _PrettyNeumorphicButtonState extends State<PrettyNeumorphicButton> {
  bool _isElevated = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isElevated = false;
        });
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() {
          _isElevated = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isElevated = true;
        });
      },
      child: AnimatedContainer(
        duration: widget.duration ?? duration500,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: s42, vertical: s14),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(widget.borderRadius ?? s50),
          // when _isElevated is false, value
          // of inset parameter will be true
          // that will create depth effect.
          boxShadow: _isElevated
              ? [
                  const BoxShadow(
                    color: Color(0xFFBEBEBE),
                    // Shadow for bottom right corner
                    offset: Offset(10, 10),
                    blurRadius: 10,
                    spreadRadius: 1,
                    inset: false,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    // Shadow for top left corner
                    offset: Offset(-10, -10),
                    blurRadius: 10,
                    spreadRadius: 1,
                    inset: false,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Color(0xFFBEBEBE),
                    // Shadow for bottom right corner
                    offset: Offset(10, 10),
                    blurRadius: 10,
                    spreadRadius: 1,
                    inset: true,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    // Shadow for top left corner
                    offset: Offset(-10, -10),
                    blurRadius: 10,
                    spreadRadius: 1,
                    inset: true,
                  ),
                ],
        ),
        child: Text(
          widget.label,
          style: widget.labelStyle,
        ),
      ),
    );
  }
}
