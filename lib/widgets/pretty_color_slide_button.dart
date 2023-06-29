import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/enums/slide_positions.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';
import 'package:pretty_buttons/util/animated_color_text.dart';

/// [PrettyColorSlideButton] is pretty button that slides in a color when button is tapped
/// You'll have 4 slide positions - left,right,top,bottom using [position] parameter
/// When a second layer comes in, it swaps colors such that previous foreground color becomes new background color
/// and previous background color to new foreground one
class PrettyColorSlideButton extends StatefulWidget {
  const PrettyColorSlideButton({
    super.key,
    this.bgColor = kBlack,
    this.foregroundColor = kWhite,
    required this.label,
    this.labelStyle,
    this.position = SlidePosition.left,
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
        if (_controller.isCompleted) {
          _controller.reverse();
        } else if(_controller.isDismissed){
          _controller.forward();
        }
      },
      child: <Widget>[
        Container(
          width: btnSize.width,
          height: btnSize.height,
          decoration: BoxDecoration(
            color: widget.bgColor,
          ),
        ),
        SlideColorAnimation(
          animation: _controller,
          bgColor: widget.foregroundColor,
          btnSize: btnSize,
          position: widget.position,
        ),
        SizedBox(
          width: btnSize.width,
          height: btnSize.height,
          child: AnimatedColorText(
            label: widget.label,
            labelStyle: widget.labelStyle,
            animation: _controller,
            firstColor: (widget.position == SlidePosition.left ||
                    widget.position == SlidePosition.top)
                ? widget.foregroundColor
                : widget.bgColor,
            secondColor: (widget.position == SlidePosition.left ||
                    widget.position == SlidePosition.top)
                ? widget.bgColor
                : widget.foregroundColor,
          ),
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
    required this.btnSize,
    required this.position,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final Color bgColor;
  final Size btnSize;
  final SlidePosition position;

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  Animation<double> get heightAnimation => Tween<double>(
        begin: isTop ? s0 : btnSize.height,
        end: isTop ? btnSize.height : s0,
      ).animate(curvedAnimation);

  Animation<double> get widthAnimation => Tween<double>(
        begin: isLeft ? s0 : btnSize.width,
        end: isLeft ? btnSize.width : s0,
      ).animate(curvedAnimation);

  bool get isTop => position == SlidePosition.top;
  bool get isLeft => position == SlidePosition.left;
  bool get isVertical => isTop || position == SlidePosition.bottom;
  bool get isHorizontal =>
      position == SlidePosition.left || position == SlidePosition.right;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHorizontal ? widthAnimation.value : btnSize.width,
      height: isVertical ? heightAnimation.value : btnSize.height,
      decoration: BoxDecoration(
        color: bgColor,
      ),
    );
  }
}
