import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/string_ex.dart';

/// [PrettySkewButton] is a parallelogram button
/// that has the same behaviour with [PrettyColorSlideButton]
/// when tapped secondary color slides in from the left or center ( here, you'll have only 2 choices )
class PrettySkewButton extends StatefulWidget {
  const PrettySkewButton({super.key});

  @override
  State<PrettySkewButton> createState() => _PrettySkewButtonState();
}

class _PrettySkewButtonState extends State<PrettySkewButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String label = 'Pretty Skew Button';
  final TextStyle labelStyle = const TextStyle(fontSize: 16);
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    vertical: s14,
    horizontal: s24,
  );
  late Size textSize;
  late Size containerSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
    textSize = label.textSize(
      style: labelStyle,
    );
    containerSize = Size(
      textSize.width + padding.horizontal,
      textSize.height + padding.vertical,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.reset();
        _controller.forward();
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: containerSize.width,
            height: containerSize.height,
            margin: const EdgeInsets.only(left: 12.0),
            transform: Matrix4.skewX(-.3),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.amber,
            ),
          ),
          SlideContainer(
            animation: _controller,
            containerSize: containerSize,
          ),
          SizedBox(
            width: containerSize.width,
            height: containerSize.height,
            child: Center(
              child: Text(
                label,
                style: labelStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideContainer extends AnimatedWidget {
  const SlideContainer({
    super.key,
    required this.animation,
    required this.containerSize,
  }) : super(listenable: animation);
  final Animation<double> animation;
  final Size containerSize;

  Animation<double> get slideAnimation =>
      Tween<double>(begin: 0.0, end: containerSize.width)
          .animate(curvedAnimation);
  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: slideAnimation.value,
      height: containerSize.height,
      margin: const EdgeInsets.only(left: 12.0),
      transform: Matrix4.skewX(-.3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
        ),
        color: Colors.teal,
      ),
    );
  }
}
