import 'package:flutter/material.dart';

class AnimatedColorText extends AnimatedWidget {
  const AnimatedColorText({
    super.key,
    required this.animation,
    required this.label,
    this.labelStyle,
    required this.firstColor,
    required this.secondColor,
  }) : super(
          listenable: animation,
        );
  final String label;
  final TextStyle? labelStyle;
  final Animation<double> animation;
  final Color firstColor;
  final Color secondColor;

  Animation<Color?> get colorAnimation =>
      ColorTween(begin: firstColor, end: secondColor).animate(curvedAnimation);
  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: labelStyle != null
            ? labelStyle?.copyWith(
                color: colorAnimation.value!,
              )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorAnimation.value!,
                ),
      ),
    );
  }
}
