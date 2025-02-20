import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_colors.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';
import 'package:pretty_animated_buttons/extensions/widget_ex.dart';

/// [PrettySlideUpButton] has two children
/// It always shows first child if there's no interaction such as pressing the button
/// When tapped, first child slides up and second child replaces the first child's place
///
class PrettySlideUpButton extends StatefulWidget {
  const PrettySlideUpButton({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: s12, horizontal: s24),
    required this.firstChild,
    required this.secondChild,
    this.bgColor = kBlack,
    this.borderRadius = s5,
    this.duration = duration500,
    this.curve = Curves.easeInOut,
    required this.onPressed,
  });
  final EdgeInsetsGeometry? padding;
  final Widget firstChild;
  final Widget secondChild;
  final Color bgColor;
  final double borderRadius;
  final Duration duration;
  final Curve curve;
  final VoidCallback onPressed;
  @override
  State<PrettySlideUpButton> createState() => _PrettySlideUpButtonState();
}

class _PrettySlideUpButtonState extends State<PrettySlideUpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<Offset> get firstSlideUpAnimation =>
      Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
          .animate(firstAnimation);
  Animation<double> get firstOpacityAnimation =>
      Tween<double>(begin: s1, end: s0).animate(firstAnimation);

  Animation<double> get firstAnimation => CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0,
          0.5,
          curve: widget.curve,
        ),
      );

  Animation<Offset> get secondSlideUpAnimation => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        secondAnimation,
      );
  Animation<double> get secondOpacityAnimation =>
      Tween<double>(begin: s0, end: s18).animate(secondAnimation);
  Animation<double> get secondAnimation => CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1.0,
          curve: widget.curve,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isCompleted) {
          _controller.reverse();
        } else if (_controller.isDismissed) {
          _controller.forward();
        }
        widget.onPressed();
      },
      child: <Widget>[
        FadeTransition(
          opacity: firstOpacityAnimation,
          child: SlideTransition(
            position: firstSlideUpAnimation,
            child: widget.firstChild,
          ),
        ),
        FadeTransition(
          opacity: secondOpacityAnimation,
          child: SlideTransition(
            position: secondSlideUpAnimation,
            child: widget.secondChild,
          ),
        ),
      ]
          .addStack(
            alignment: Alignment.center,
          )
          .addContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                widget.borderRadius,
              ),
              color: widget.bgColor,
            ),
            padding: widget.padding,
          ),
    );
  }
}
