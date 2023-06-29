import 'package:flutter/material.dart';
import 'package:pretty_buttons/configs/pkg_colors.dart';
import 'package:pretty_buttons/configs/pkg_sizes.dart';
import 'package:pretty_buttons/extensions/widget_ex.dart';

class PrettyCapsuleButton extends StatefulWidget {
  const PrettyCapsuleButton({
    super.key,
    this.textStyle,
  });
  final String label = 'Pretty Capsule Button';
  final TextStyle? textStyle;
  @override
  State<PrettyCapsuleButton> createState() => _PrettyCapsuleButtonState();
}

class _PrettyCapsuleButtonState extends State<PrettyCapsuleButton> {
  late Size textSize;
  late Size containerSize;
  @override
  void initState() {
    super.initState();
    // textSize = widget.label.textSize(
    //   style: widget.labelStyle,
    // );
    // containerSize = Size(
    //   textSize.width + padding.horizontal,
    //   textSize.height + padding.vertical,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: s40,
              height: s40,
              decoration: BoxDecoration(
                color: kBlack,
                borderRadius: BorderRadius.circular(s50),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: kWhite,
                ),
              ),
            ),
            Text('Pretty Capsule Button'),
          ],
        )
      ],
    ).addContainer(
      color: kTeal200,
      padding: const EdgeInsets.symmetric(
        horizontal: s24,
        vertical: s14,
      ),
    );
  }
}
