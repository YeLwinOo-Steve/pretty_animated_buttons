import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';
import 'package:pretty_animated_buttons/extensions/string_ex.dart';
import 'package:pretty_animated_buttons/extensions/widget_ex.dart';
import 'package:pretty_animated_buttons/util/animated_horizontal_stick.dart';

/// [PrettySlideUnderlineButton] is animated button
/// that creates slide underline animation and moves the icon to the right a bit
/// when user taps on the button
/// There are two underline slide animations and
/// you can specify each color using [firstSlideColor] & [secondSlideColor] parameters
class PrettySlideUnderlineButton extends StatefulWidget {
  const PrettySlideUnderlineButton({
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
  State<PrettySlideUnderlineButton> createState() => _PrettySlideUnderlineButtonState();
}

class _PrettySlideUnderlineButtonState extends State<PrettySlideUnderlineButton>
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
