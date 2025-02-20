import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';

class PrettyShineButton extends StatefulWidget {
  const PrettyShineButton({
    Key? key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(vertical: s12, horizontal: s24),
    required this.onPressed,
    this.bgColor = Colors.teal,
    this.borderRadius = s5,
    this.duration = duration500,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color bgColor;
  final double borderRadius;
  final Duration duration;
  final Curve curve;
  final EdgeInsetsGeometry padding;
  @override
  State<PrettyShineButton> createState() => _PrettyShineButtonState();
}

class _PrettyShineButtonState extends State<PrettyShineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Padding(
              padding: widget.padding,
              child: Center(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (_isAnimating)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    left: -15,
                    top: -100,
                    child: Transform.rotate(
                      angle: 45 * pi / 180,
                      child: Transform.scale(
                        scale: Tween<double>(begin: 2, end: 50)
                            .animate(CurvedAnimation(
                              parent: _controller,
                              curve: Curves.linear,
                            ))
                            .value,
                        child: Opacity(
                          opacity: Tween<double>(begin: 0.8, end: 0)
                              .animate(CurvedAnimation(
                                parent: _controller,
                                curve: Curves.linear,
                              ))
                              .value,
                          child: Container(
                            width: 30,
                            height: 100,
                            decoration: BoxDecoration(
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
              ),
          ],
        ),
      ),
    );
  }
}
