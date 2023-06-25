import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/enums/slide_positions.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';

class PrettyColorSlideButton extends StatefulWidget {
  const PrettyColorSlideButton({
    super.key,
    this.bgColor = kBlack,
    this.foregroundColor = kWhite,
    required this.label,
    this.labelStyle,
    this.position = SlidePosition.bottom,
    this.padding = const EdgeInsets.symmetric(horizontal: s24, vertical: s14),
  });
  final Color bgColor;
  final Color foregroundColor;
  final String label;
  final TextStyle? labelStyle;
  final SlidePosition position;
  final EdgeInsetsGeometry? padding;
  @override
  State<PrettyColorSlideButton> createState() => _PrettyColorSlideButtonState();
}

class _PrettyColorSlideButtonState extends State<PrettyColorSlideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size textSize;
  late Size btnSize;
  TextStyle? labelStyle;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration500);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    labelStyle = widget.labelStyle ?? Theme.of(context).textTheme.bodyMedium;
    textSize = widget.label.textSize(
      style: labelStyle,
    );
    btnSize = Size(
      textSize.width + widget.padding!.horizontal,
      textSize.height + widget.padding!.vertical,
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
        _controller.reset();
        _controller.forward();
      },
      child: <Widget>[
        Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.bgColor,
          ),
          child: Text(
            'Pretty Color Slide Button',
            style: TextStyle(
              color: widget.foregroundColor,
            ),
          ),
        ),
        SlideColorAnimation(
          animation: _controller,
          bgColor: widget.foregroundColor,
          foregroundColor: widget.bgColor,
          btnSize: btnSize,
          padding: widget.padding,
          position: widget.position,
        ),
      ].addStack(),
    );
  }
}

class SlideColorAnimation extends AnimatedWidget {
  const SlideColorAnimation({
    super.key,
    required this.animation,
    required this.bgColor,
    required this.foregroundColor,
    required this.btnSize,
    required this.padding,
    required this.position,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final Color bgColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;
  final Size btnSize;
  final SlidePosition position;

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  Animation<double> get heightAnimation =>
      Tween<double>(begin: btnSize.height, end: s0).animate(curvedAnimation);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: position == SlidePosition.top
       ? Alignment.topCenter : Alignment.bottomCenter,
      width: btnSize.width,
      height: heightAnimation.value,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Text(
        'Pretty Color Slide Button',
        style: TextStyle(color: foregroundColor),
      ),
    );
  }
}
