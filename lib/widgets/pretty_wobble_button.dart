import 'dart:math';

import 'package:flutter/material.dart';

class WobbleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const WobbleButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<WobbleButton> createState() => _WobbleButtonState();
}

class _WobbleButtonState extends State<WobbleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final toRadians = pi / 180;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 5 * toRadians), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: 5 * toRadians, end: -4 * toRadians), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: -4 * toRadians, end: 3 * toRadians), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: 3 * toRadians, end: -2 * toRadians), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: -2 * toRadians, end: 1 * toRadians), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: 1 * toRadians, end: -0.5 * toRadians), weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: -0.5 * toRadians, end: 0.25 * toRadians),
          weight: 5),
      TweenSequenceItem(
          tween: Tween(begin: 0.25 * toRadians, end: 0.0), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 60),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.skew(_animation.value, _animation.value),
          child: GestureDetector(
            onTap: () {
              _controller.reset();
              _controller.forward();
              widget.onPressed();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.teal,
              ),
              width: 300,
              height: 80,
              child: Center(
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
