import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_colors.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';
import 'package:pretty_animated_buttons/extensions/widget_ex.dart';

/// [PrettyShadowButton] is animated button that consists of two main parts - Button part, Shadow part
/// In Button part, you can add label and an icon
/// In Shadow part, it moves when button is tapped
/// Original elevation is 8.0 but you can tweak using [elevation] parameter
///
class PrettyShadowButton extends StatefulWidget {
  const PrettyShadowButton({
    Key? key,
    required this.label,
    this.bgColor = kWhite,
    this.foregroundColor = kBlack,
    this.shadowColor,
    required this.onPressed,
    this.icon,
    this.duration,
    this.elevation,
    this.verticalPadding,
    this.horizontalPadding,
    this.labelStyle,
  }) : super(key: key);
  final String label;
  final Color bgColor;
  final Color foregroundColor;
  final Color? shadowColor;
  final VoidCallback onPressed;
  final IconData? icon;

  final double? verticalPadding;
  final double? horizontalPadding;
  final Duration? duration;
  final double? elevation;
  final TextStyle? labelStyle;
  @override
  State<PrettyShadowButton> createState() => _PrettyShadowButtonState();
}

class _PrettyShadowButtonState extends State<PrettyShadowButton> {
  bool _isTapped = false;
  double elevation = 0.0;
  Duration duration = Duration.zero;

  @override
  void initState() {
    elevation = widget.elevation ?? s8;
    duration = widget.duration ?? duration100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        widget.onPressed();
        setState(() {
          _isTapped = true;
        });
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
        AnimatedPositioned(
          left: _isTapped ? elevation : s0,
          bottom: _isTapped ? elevation : s0,
          duration: duration,
          curve: Curves.easeInOut,
          child: <Widget>[
            Text(
              widget.label,
              style: widget.labelStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.shadowColor ?? kTeal200,
                      ),
            ),
            customSpace(w: _isTapped ? s10 : s5),
            widget.icon != null
                ? Icon(
                    widget.icon,
                    color: widget.shadowColor ?? kTeal200,
                  )
                : zeroSize,
          ]
              .addRow(
                mainAxisSize: MainAxisSize.min,
              )
              .addContainer(
                padding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding ?? s14,
                  horizontal: widget.horizontalPadding ?? s42,
                ),
                decoration: BoxDecoration(
                  color: widget.shadowColor ?? kTeal200,
                  border: Border.all(
                    color: widget.shadowColor ?? kTeal200,
                  ),
                ),
              ),
        ),
        <Widget>[
          Text(
            widget.label,
            style: widget.labelStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: widget.foregroundColor,
                    ),
          ),
          AnimatedContainer(
            width: _isTapped ? s10 : s5,
            duration: duration,
            curve: Curves.easeInOut,
          ),
          widget.icon != null
              ? Icon(
                  widget.icon,
                  color: widget.foregroundColor,
                )
              : zeroSize,
        ]
            .addRow(
              mainAxisSize: MainAxisSize.min,
            )
            .addContainer(
              margin: EdgeInsets.only(
                left: elevation,
                bottom: elevation,
              ),
              padding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding ?? s14,
                horizontal: widget.horizontalPadding ?? s42,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.foregroundColor,
                ),
              ),
            ),
      ].addStack(),
    );
  }
}
