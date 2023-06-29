import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';


const double factor = 0.2;

class AnimatedHorizontalStick extends AnimatedWidget {
  const AnimatedHorizontalStick({
    super.key,
    required this.animation,
    required this.targetWidth,
    this.firstSlideColor,
    this.secondSlideColor,
    this.underlineHeight,
  }) : super(
    listenable: animation,
  );
  final Animation<double> animation;
  final double targetWidth;
  final double height = s2;
  final Color? firstSlideColor;
  final Color? secondSlideColor;
  final double? underlineHeight;

  Animation<double> get firstSlideTween =>
      Tween<double>(begin: s0, end: targetWidth - factor).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.5,
            curve: Curves.easeInOut,
          ),
        ),
      );
  Animation<double> get secondSlideTween =>
      Tween<double>(begin: s0, end: targetWidth).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.5,
            1,
            curve: Curves.easeInOut,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Positioned(
        left: factor,
        top: factor,
        child: Container(
          width: firstSlideTween.value,
          height: (underlineHeight ?? s2) - factor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s10),
            color: firstSlideColor ?? kBlack,
          ),
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
          width: secondSlideTween.value,
          height: underlineHeight ?? s3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s10),
            color: secondSlideColor ?? kWhite,
          ),
        ),
      )
    ].addStack().addSizedBox(
      width: targetWidth,
      height: underlineHeight ?? s2,
    );
  }
}
