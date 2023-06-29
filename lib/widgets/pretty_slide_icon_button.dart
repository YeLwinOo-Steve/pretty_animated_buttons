import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/enums/slide_positions.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';

/// [PrettySlideIconButton] is an animated slide icon button
/// creates slide icon animation when hovering on web and
/// when tapping on other platforms
/// Tweak slide animation positions by using [SlidePosition.left] or [SlidePosition.right]
///
class PrettySlideIconButton extends StatefulWidget {
  const PrettySlideIconButton({
    super.key,
    required this.foregroundColor,
    required this.icon,
    required this.label,
    required this.labelStyle,
    this.slidePosition = SlidePosition.left,
    this.duration = duration500,
    this.curve = Curves.easeInOut,
    this.padding = const EdgeInsets.symmetric(
      horizontal: s24,
      vertical: s12,
    ),
    this.borderWidth = s1,
  });
  final Color foregroundColor;
  final IconData icon;
  final String label;
  final TextStyle labelStyle;
  final SlidePosition slidePosition;
  final Duration duration;
  final Curve curve;
  final EdgeInsetsGeometry padding;
  final double borderWidth;
  @override
  State<PrettySlideIconButton> createState() => _PrettySlideIconButtonState();
}

class _PrettySlideIconButtonState extends State<PrettySlideIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        if (kIsWeb) {
          _controller.forward();
        }
      },
      onExit: (_) {
        if (kIsWeb) {
          _controller.reverse();
        }
      },
      child: GestureDetector(
        onTap: () {
          _controller.reset();
          _controller.forward();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s50),
            border: Border.all(
              color: widget.foregroundColor,
              width: widget.borderWidth,
            ),
          ),
          padding: widget.padding,
          child: <Widget>[
            Text(
              widget.label,
              style: widget.labelStyle.copyWith(
                color: widget.foregroundColor,
              ),
            ),
            horizontalSpaceMedium,
            SlideIcon(
              animation: _controller,
              icon: widget.icon,
              color: widget.foregroundColor,
              slidePosition: widget.slidePosition,
              curve: widget.curve,
            ),
          ].addRow(
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      ),
    );
  }
}

class SlideIcon extends StatelessWidget {
  const SlideIcon({
    super.key,
    required this.animation,
    required this.icon,
    required this.color,
    required this.slidePosition,
    this.curve = Curves.easeInOut,
  });
  final Animation<double> animation;
  final SlidePosition slidePosition;
  final Curve curve;
  final IconData icon;
  final Color color;
  Animation<Offset> get leftSlideAnimation =>
      Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
          .animate(curvedAnimation);
  Animation<Offset> get rightSlideAnimation =>
      Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(curvedAnimation);

  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: curve,
      );
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: curvedAnimation,
      child: SlideTransition(
        position: slidePosition == SlidePosition.left
            ? leftSlideAnimation
            : rightSlideAnimation,
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
