import 'package:flutter/material.dart';

import 'custom_arrow.dart';

class ShimmerArrowUp extends StatefulWidget {
  const ShimmerArrowUp({Key? key}) : super(key: key);

  @override
  State<ShimmerArrowUp> createState() => _ShimmerArrowUpState();
}

class _ShimmerArrowUpState extends State<ShimmerArrowUp> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: Duration(seconds: 4));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: _SlideGradientTransform(percent: _animationController.value),
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTRB(0, 0, bounds!.width, bounds.height)),
          child: Column(
            children: [
              Transform.translate(
                offset: Offset(0, _animationController.value * 10), // Adjust the multiplier as needed
                child: RotatedText(
                  angle: 270, // Rotation angle in degrees
                  color: Colors.white, // Text color
                  fontSize: 70, // Text size
                  text: "IN", // Text content
                ),
              ),
              Transform.translate(
                offset: Offset(0, _animationController.value * 10), // Adjust the multiplier as needed
                child: RotatedText(
                  angle: 270, // Rotation angle in degrees
                  color: Colors.white, // Text color
                  fontSize: 70, // Text size
                  text: "IGN", // Text content
                ),
              ),
              Transform.translate(
                offset: Offset(0, _animationController.value * 0), // Adjust the multiplier as needed
                child: RotatedText(
                  angle: 270, // Rotation angle in degrees
                  color: Colors.white, // Text color
                  fontSize: 70, // Text size
                  text: "S", // Text content
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double percent;
  _SlideGradientTransform({required this.percent});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(0, -bounds.height * percent, 0);
  }
}


class ShimmerArrowDown extends StatefulWidget {
  const ShimmerArrowDown({Key? key}) : super(key: key);

  @override
  State<ShimmerArrowDown> createState() => _ShimmerArrowDownState();
}

class _ShimmerArrowDownState extends State<ShimmerArrowDown> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: Duration(seconds: 5));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: _SlideGradientTransform(percent: _animationController.value),
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTRB( bounds!.width, bounds.height,0, 0)),
          child: Column(
            children: [
              Transform.translate(
                offset: Offset(0, _animationController.value * 0), // Adjust the multiplier as needed
                child: RotatedText(
                  angle: 90, // Rotation angle in degrees
                  color: Colors.white, // Text color
                  fontSize: 70, // Text size
                  text: "S", // Text content
                ),
              ),
              Transform.translate(
                offset: Offset(0, _animationController.value * 10), // Adjust the multiplier as needed
                child: RotatedText(
                  angle: 90, // Rotation angle in degrees
                  color: Colors.white, // Text color
                  fontSize: 70, // Text size
                  text: "IGN", // Text content
                ),
              ),
              Transform.translate(
                offset: Offset(0, _animationController.value * 10), // Adjust the multiplier as needed
                child: RotatedText(
                  angle: 90, // Rotation angle in degrees
                  color: Colors.white, // Text color
                  fontSize: 70, // Text size
                  text: "UP", // Text content
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

