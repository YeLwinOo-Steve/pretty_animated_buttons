import 'package:flutter/material.dart';

class PrettyThreeDButton extends StatefulWidget {
  const PrettyThreeDButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.shadowColor,
    this.labelStyle,
    this.size,
  });
  final String label;
  final Size? size;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final Color color;
  final Color? shadowColor;

  @override
  State<PrettyThreeDButton> createState() => _PrettyThreeDButtonState();
}

class _PrettyThreeDButtonState extends State<PrettyThreeDButton> {
  bool _isTapped = false;
  final tapElevationDuration = const Duration(milliseconds: 100);

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
        widget.onPressed.call();
      },
      onTapUp: (_) => _disableButtonTap(),
      onTapCancel: _disableButtonTap,
      child: AnimatedContainer(
        duration: tapElevationDuration,
        curve: Curves.easeOutCubic, // Changed for smoother animation
        height: widget.size?.height,
        width: widget.size?.width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        transform: _isTapped
            ? Matrix4.translationValues(0, 4, 0) // Reduced press distance
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.color.brighten(0.1), // Top highlight
              widget.color,
              widget.color.darken(0.1), // Bottom shadow
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.color.brighten(0.2),
            width: 1,
          ),
          boxShadow: [
            // Ambient shadow
            BoxShadow(
              color: (widget.shadowColor ?? widget.color).withOpacity(0.2),
              offset: _isTapped ? const Offset(0, 2) : const Offset(0, 6),
              blurRadius: 8,
              spreadRadius: 0,
            ),
            // Strong bottom shadow
            BoxShadow(
              color: (widget.shadowColor ?? widget.color).withOpacity(0.4),
              offset: _isTapped ? const Offset(0, 3) : const Offset(0, 8),
              blurRadius: 4,
              spreadRadius: 0,
            ),
            // Inner shadow when pressed
            if (_isTapped)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: -1,
                // inset: true,
              ),
          ],
        ),
        child: Center(
          child: Text(
            widget.label,
            style: widget.labelStyle?.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ) ??
                const TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

extension ColorExtension on Color {
  Color darken(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness * (1 - amount)).clamp(0.0, 1.0))
        .toColor();
  }

  Color brighten(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness(
            (hsl.lightness + (1 - hsl.lightness) * amount).clamp(0.0, 1.0))
        .toColor();
  }
}
