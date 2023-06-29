import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_colors.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';

/// [PrettyFuzzyButton] makes glowing effect when tapping in mobile devices or hovering it in web
/// The button slides up a little bit when tapping or hovering
class PrettyFuzzyButton extends StatefulWidget {
  const PrettyFuzzyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelStyle,
    this.foregroundColor = kBlack,
    this.margin = s10,
    this.radius = s5,
    this.originalColor = kWhite,
    this.secondaryColor = kGreen,
  });
  final String label;
  final TextStyle? labelStyle;
  final Color? foregroundColor;
  final double margin;
  final double radius;
  final Color originalColor;
  final Color secondaryColor;
  final VoidCallback onPressed;
  @override
  State<PrettyFuzzyButton> createState() => _PrettyFuzzyButtonState();
}

class _PrettyFuzzyButtonState extends State<PrettyFuzzyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double margin;
  late double radius;
  bool _isHovered = false;
  late Color secondaryColor;
  late Color originalColor;

  @override
  void initState() {
    super.initState();
    margin = widget.margin;
    radius = widget.radius;
    originalColor = widget.originalColor;
    secondaryColor = widget.secondaryColor;
    _controller = AnimationController(vsync: this, duration: duration500);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
          _controller.forward();
          setState(() {
            _isHovered = true;
          });
          widget.onPressed();
      },
      onTapUp: (_){
        _controller.reverse();
        setState(() {
          _isHovered = false;
        });
      },
      onTapCancel: (){
        _controller.reverse();
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedMargin(
        animation: _controller,
        position: margin,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s50),
            color: _isHovered ? secondaryColor : originalColor,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: secondaryColor.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 10), // changes position of shadow
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: s14,
            horizontal: s42,
          ),
          child: _AnimatedColorText(
            label: widget.label,
            labelStyle: widget.labelStyle,
            animation: _controller,
            firstColor: kBlack,
            secondColor: kWhite,
          ),
        ),
      ),
    );
  }
}

class _AnimatedColorText extends AnimatedWidget {
  const _AnimatedColorText({
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
    return Text(
      label,
      style: labelStyle != null
          ? labelStyle?.copyWith(
              color: colorAnimation.value!,
            )
          : Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorAnimation.value!,
              ),
    );
  }
}

class AnimatedMargin extends AnimatedWidget {
  const AnimatedMargin({
    super.key,
    required this.animation,
    required this.position,
    required this.child,
  }) : super(listenable: animation);
  final Animation<double> animation;
  final Widget child;
  final double position;

  Animation<double> get marginAnimation => Tween<double>(
        begin: s0,
        end: position,
      ).animate(curvedAnimation);
  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: marginAnimation.value,
      ),
      child: child,
    );
  }
}
