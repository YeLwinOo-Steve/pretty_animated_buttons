import 'package:flutter/material.dart';

class PrettyThreeDButton extends StatefulWidget {
  const PrettyThreeDButton({
    super.key,
    required this.label,
    required this.color,
    this.shadowColor,
    this.dimensions,
  });
  final String label;
  final ({double width, double height})? dimensions;
  final Color color;
  final Color? shadowColor;

  @override
  State<PrettyThreeDButton> createState() => _PrettyThreeDButtonState();
}

class _PrettyThreeDButtonState extends State<PrettyThreeDButton> {
  bool _isTapped = false;
  final tapElevationDuration = const Duration(milliseconds: 200);

  void _disableButtonTap() {
    Future.delayed(tapElevationDuration, () {
      setState(() => _isTapped = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isTapped = true);
        Future.delayed(
          tapElevationDuration,
          () {},
        );
      },
      onTapUp: (_) => _disableButtonTap(),
      onTapCancel: _disableButtonTap,
      child: AnimatedContainer(
        duration: tapElevationDuration,
        curve: Curves.bounceInOut,
        // height: 120,
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 12),
        transform: _isTapped
            ? Matrix4.translationValues(0, 5, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor ?? widget.color.withOpacity(0.3),
              offset: _isTapped ? const Offset(0, 0) : const Offset(5, 5),
            ),
          ],
        ),
        child: const Center(
          child: Text('Tap Me'),
        ),
      ),
    );
  }
}
