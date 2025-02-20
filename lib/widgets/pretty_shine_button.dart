import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class PrettyShineButton extends StatefulWidget {
  const PrettyShineButton({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: s12, horizontal: s24),
    required this.onPressed,
    this.bgColor = Colors.teal,
    this.borderRadius = s5,
    this.duration = duration500,
    this.curve = Curves.easeInOut,
    this.slidePosition = ShineSlidePositions.topLeft,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color bgColor;
  final double borderRadius;
  final Duration duration;
  final Curve curve;
  final ShineSlidePositions slidePosition;
  final EdgeInsetsGeometry padding;
  @override
  State<PrettyShineButton> createState() => _PrettyShineButtonState();
}

class _PrettyShineButtonState extends State<PrettyShineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimating = false;
  final toRadians = pi / 180;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() => _isAnimating = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() => _isAnimating = true);
    _controller.forward();
    widget.onPressed();
  }

  Offset get _getStartPosition => switch (widget.slidePosition) {
        ShineSlidePositions.topLeft => const Offset(-15, -100),
        ShineSlidePositions.topRight => const Offset(100, -100),
        ShineSlidePositions.bottomLeft => const Offset(-15, 100),
        ShineSlidePositions.bottomRight => const Offset(100, 100),
      };

  double get _getRotationAngle => switch (widget.slidePosition) {
        ShineSlidePositions.topLeft => 45 * toRadians,
        ShineSlidePositions.topRight => 135 * toRadians,
        ShineSlidePositions.bottomLeft => -45 * toRadians,
        ShineSlidePositions.bottomRight => -135 * toRadians,
      };

  Widget _buildShineEffect() {
    final startPosition = _getStartPosition;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: startPosition.dx,
          top: startPosition.dy,
          child: Transform.rotate(
            angle: _getRotationAngle,
            child: Transform.scale(
              scale: Tween<double>(begin: 0, end: 100)
                  .animate(CurvedAnimation(
                    parent: _controller,
                    curve: Curves.linear,
                  ))
                  .value,
              child: Opacity(
                opacity: Tween<double>(begin: 0.7, end: 0)
                    .animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.linear,
                    ))
                    .value,
                child: Container(
                  width: 30,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: .5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Padding(
                padding: widget.padding,
                child: widget.child,
              ),
              if (_isAnimating) _buildShineEffect(),
            ],
          ),
        );
      }),
    );
  }
}
