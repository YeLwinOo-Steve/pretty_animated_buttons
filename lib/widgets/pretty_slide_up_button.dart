import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';

class PrettySlideUpButton extends StatefulWidget {
  const PrettySlideUpButton({
    super.key,
    this.verticalPadding,
    this.horizontalPadding,
  });
  final double? verticalPadding;
  final double? horizontalPadding;
  @override
  State<PrettySlideUpButton> createState() => _PrettySlideUpButtonState();
}

class _PrettySlideUpButtonState extends State<PrettySlideUpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: duration500,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
      },
      child: SlideUpText(
        controller: _controller,
      ),
    );
  }
}

class SlideUpText extends AnimatedWidget {
  const SlideUpText({super.key, required this.controller})
      : super(
          listenable: controller,
        );
  final Animation<double> controller;
  Animation<Offset> get upperSlideUpAnimation =>
      Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(
            0,
            0.5,
            curve: Curves.easeInOut,
          ),
        ),
      );

  Animation<Offset> get lowerSlideUpAnimation => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(
            0.5,
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      );

  Animation<String> get textAnimation =>
      Tween<String>(begin: 'I love you', end: 'yoh yoh').animate(controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s5),
        color: kTeal200,
      ),
      padding: const EdgeInsets.symmetric(vertical: s12, horizontal: s24),
      child: Center(
        child: Stack(
          children: [
            SlideTransition(
              position: upperSlideUpAnimation,
              child: Text(
                textAnimation.value,
              ),
            ),
            SlideTransition(
              position: lowerSlideUpAnimation,
              child: Text(
                textAnimation.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
