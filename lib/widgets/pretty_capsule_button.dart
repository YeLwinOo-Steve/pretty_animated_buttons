import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';
import 'package:pretty_buttons/util/animated_color_text.dart';

/// [PrettyCapsuleButton] is an animated button that contains a leading icon and a label
/// When pressing the button in mobile device or hovering it in web,
/// the circle that has an icon becomes a capsule and wraps the text
/// the icon moves right a little bit and the text color changes
class PrettyCapsuleButton extends StatefulWidget {
  const PrettyCapsuleButton({
    super.key,
    this.labelStyle,
    required this.label,
    this.bgColor = kBlack,
    this.foregroundColor = kWhite,
    this.icon = Icons.arrow_forward_ios,
    this.iconSize = 16,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: s24, vertical: s14),
  });
  final String label;
  final TextStyle? labelStyle;
  final Color bgColor;
  final Color foregroundColor;
  final IconData icon;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final VoidCallback onPressed;
  @override
  State<PrettyCapsuleButton> createState() => _PrettyCapsuleButtonState();
}

class _PrettyCapsuleButtonState extends State<PrettyCapsuleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size textSize;
  late Size containerSize;
  @override
  void initState() {
    super.initState();
    textSize = widget.label.textSize(
      style: widget.labelStyle,
    );
    containerSize = Size(
      textSize.width + widget.padding.horizontal,
      textSize.height + widget.padding.vertical,
    );
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
      onTap: () {
        _controller.reset();
        _controller.forward();
        widget.onPressed();
      },
      child: <Widget>[
        _BackgroundCapsule(
          animation: _controller,
          containerSize: containerSize,
          textSize: textSize,
          padding: widget.padding,
          backgroundColor: widget.bgColor,
          foregroundColor: widget.foregroundColor,
          icon: widget.icon,
          iconSize: widget.iconSize,
        ),
        Positioned.fill(
          left: s10,
          child: AnimatedColorText(
            label: widget.label,
            labelStyle: widget.labelStyle,
            firstColor: widget.bgColor,
            secondColor: widget.foregroundColor,
            animation: _controller,
          ).addCenter(),
        ),
      ].addStack(),
    );
  }
}

class _BackgroundCapsule extends AnimatedWidget {
  const _BackgroundCapsule({
    required this.animation,
    required this.containerSize,
    required this.textSize,
    required this.padding,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.iconSize,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final Size containerSize;
  final Size textSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

  Animation<double> get widthAnimation =>
      Tween<double>(begin: s0, end: containerSize.width)
          .animate(curvedAnimation);
  Animation<double> get paddingAnimation =>
      Tween<double>(begin: containerSize.height, end: padding.horizontal * 0.5)
          .animate(curvedAnimation);

  Animation<double> get iconSlideAnimation => Tween<double>(
        begin: containerSize.height * 0.5 - iconSize * 0.5,
        end: padding.horizontal * 0.4,
      ).animate(curvedAnimation);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        <Widget>[
          Icon(
            icon,
            size: iconSize,
            color: foregroundColor,
          ).addPadding(
            edgeInsets: EdgeInsets.only(
              left: iconSlideAnimation.value,
            ),
          ),
        ]
            .addRow(
              mainAxisSize: MainAxisSize.min,
            )
            .addContainer(
              width: paddingAnimation.value + widthAnimation.value,
              height: containerSize.height,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(s50),
              ),
            ),
        SizedBox(
          width: containerSize.width - widthAnimation.value,
          height: containerSize.height,
        ),
      ],
    );
  }
}
