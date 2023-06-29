import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';

/// [PrettyBarButton] is an animated bar button that makes a horizontal bar
/// at the upper and lower end of the button when you press the button
class PrettyBarButton extends StatefulWidget {
  const PrettyBarButton({
    super.key,
    this.borderWidth = s1,
    this.borderColor = Colors.teal,
    this.backgroundColor = kTransparent,
    required this.onPressed,
    required this.label,
    this.labelStyle,
  });
  final String label;
  final TextStyle? labelStyle;
  final double borderWidth;
  final Color borderColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  @override
  State<PrettyBarButton> createState() => _PrettyBarButtonState();
}

class _PrettyBarButtonState extends State<PrettyBarButton>
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
                color: widget.backgroundColor,
              ),
            ),
        Align(
          alignment: Alignment.topRight,
          child: _AnimatedBorder(
            animation: _controller,
            containerSize: containerSize,
            borderWidth: widget.borderWidth,
            borderColor: widget.borderColor,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _AnimatedBorder(
            animation: _controller,
            containerSize: containerSize,
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
    required this.borderWidth,
    required this.borderColor,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final Size containerSize;
  final double borderWidth;
  final Color borderColor;

  Animation<double> get animatedWidth =>
      Tween<double>(begin: s0, end: containerSize.width)
          .animate(curvedAnimation);

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animatedWidth.value,
      height: borderWidth,
      color: borderColor,
    );
  }
}
