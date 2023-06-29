import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';

/// [PrettyBorderButton] is an animated button
/// that creates a border from left bottom and top right at the same time when pressed the button in mobile devices
class PrettyBorderButton extends StatefulWidget {
  const PrettyBorderButton({
    super.key,
    this.borderWidth = s1,
    this.borderColor = Colors.teal,
    required this.label,
    this.bgColor = kWhite,
    this.labelStyle, required this.onPressed,
  });
  final String label;
  final TextStyle? labelStyle;
  final double borderWidth;
  final Color borderColor;
  final VoidCallback onPressed;
  final Color bgColor;
  @override
  State<PrettyBorderButton> createState() => _PrettyBorderButtonState();
}

class _PrettyBorderButtonState extends State<PrettyBorderButton>
    with SingleTickerProviderStateMixin {
  late EdgeInsetsGeometry padding;
  late Size textSize;
  late Size containerSize;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
    padding = const EdgeInsets.symmetric(
      vertical: s14,
      horizontal: s24,
    );
    textSize = widget.label.textSize(
      style: widget.labelStyle,
    );
    containerSize = Size(
      textSize.width + padding.horizontal,
      textSize.height + padding.vertical,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          _controller.reset();
          _controller.forward();
        }
        widget.onPressed();
      },
      child: <Widget>[
        Text(
          widget.label,
          style: widget.labelStyle,
        ).addCenter().addContainer(
              decoration: BoxDecoration(
                color: widget.bgColor,
              ),
            ),
        Align(
          alignment: Alignment.topRight,
          child: _AnimatedBorder(
            animation: _controller,
            containerSize: containerSize,
            isHorizontal: true,
            borderWidth: widget.borderWidth,
            borderColor: widget.borderColor,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _AnimatedBorder(
            animation: _controller,
            containerSize: containerSize,
            isHorizontal: false,
            borderWidth: widget.borderWidth,
            borderColor: widget.borderColor,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _AnimatedBorder(
            animation: _controller,
            containerSize: containerSize,
            isHorizontal: true,
            borderWidth: widget.borderWidth,
            borderColor: widget.borderColor,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: _AnimatedBorder(
            animation: _controller,
            containerSize: containerSize,
            isHorizontal: false,
            borderWidth: widget.borderWidth,
            borderColor: widget.borderColor,
          ),
        ),
      ]
          .addStack()
          .addSizedBox(width: containerSize.width, height: containerSize.height)
          .addCenter(),
    );
  }
}

class _AnimatedBorder extends AnimatedWidget {
  const _AnimatedBorder({
    required this.animation,
    required this.containerSize,
    required this.isHorizontal,
    required this.borderWidth,
    required this.borderColor,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final Size containerSize;
  final bool isHorizontal;
  final double borderWidth;
  final Color borderColor;

  Animation<double> get animatedWidth =>
      Tween<double>(begin: s0, end: containerSize.width)
          .animate(curvedAnimation);

  Animation<double> get animatedHeight =>
      Tween<double>(begin: s0, end: containerSize.height)
          .animate(curvedAnimation);

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHorizontal ? animatedWidth.value : borderWidth,
      height: isHorizontal ? borderWidth : animatedHeight.value,
      color: borderColor,
    );
  }
}
