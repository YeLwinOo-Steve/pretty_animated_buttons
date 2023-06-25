import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';

/// [PrettyUnderlineButton] is animated button
/// that creates slide underline animation and moves the icon to the right a bit
/// when user taps on the button
/// There are two underline slide animations and
/// you can specify each color using [firstSlideColor] & [secondSlideColor] parameters
class PrettyUnderlineButton extends StatefulWidget {
  const PrettyUnderlineButton({
    super.key,
    required this.label,
    this.labelStyle,
    this.icon,
    required this.onPressed,
    this.duration,
    this.firstSlideColor,
    this.secondSlideColor,
    this.underlineHeight,
  });
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final Icon? icon;
  final Duration? duration;
  final Color? firstSlideColor;
  final Color? secondSlideColor;
  final double? underlineHeight;
  @override
  State<PrettyUnderlineButton> createState() => _PrettyUnderlineButtonState();
}

class _PrettyUnderlineButtonState extends State<PrettyUnderlineButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  TextStyle? textStyle;
  late Size textSize;
  bool _isTapped = false;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration1000);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textStyle = widget.labelStyle ?? Theme.of(context).textTheme.bodyMedium;
    textSize = widget.label.textSize(
      style: textStyle,
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
      onTapDown: (_) {
        _controller.reset();
        _controller.forward();
        setState(() {
          _isTapped = true;
        });
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: <Widget>[
        <Widget>[
          Text(
            widget.label,
            style: textStyle,
          ),
          AnimatedContainer(
            duration: duration200,
            width: _isTapped ? s10 : s5,
          ),
          widget.icon ?? const Icon(Icons.arrow_right_alt),
        ].addRow(
          mainAxisSize: MainAxisSize.min,
        ),
        verticalSpaceTiny,
        AnimatedHorizontalStick(
          animation: _controller.view,
          targetWidth: textSize.width,
          firstSlideColor: widget.firstSlideColor,
          secondSlideColor: widget.secondSlideColor,
          underlineHeight: widget.underlineHeight,
        ),
      ].addColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

const double factor = 0.2;

class AnimatedHorizontalStick extends AnimatedWidget {
  const AnimatedHorizontalStick({
    super.key,
    required this.animation,
    required this.targetWidth,
    this.firstSlideColor,
    this.secondSlideColor,
    this.underlineHeight,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final double targetWidth;
  final double height = s2;
  final Color? firstSlideColor;
  final Color? secondSlideColor;
  final double? underlineHeight;

  Animation<double> get firstSlideTween =>
      Tween<double>(begin: s0, end: targetWidth - factor).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.5,
            curve: Curves.easeInOut,
          ),
        ),
      );
  Animation<double> get secondSlideTween =>
      Tween<double>(begin: s0, end: targetWidth).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.5,
            1,
            curve: Curves.easeInOut,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Positioned(
        left: factor,
        top: factor,
        child: Container(
          width: firstSlideTween.value,
          height: (underlineHeight ?? s2) - factor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s10),
            color: firstSlideColor ?? kBlack,
          ),
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
          width: secondSlideTween.value,
          height: underlineHeight ?? s3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s10),
            color: secondSlideColor ?? kWhite,
          ),
        ),
      )
    ].addStack().addSizedBox(
          width: targetWidth,
          height: underlineHeight ?? s2,
        );
  }
}
