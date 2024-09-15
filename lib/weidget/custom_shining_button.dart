import 'package:flutter/material.dart';

class ShinyButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final double width; // Added width property
  final double height; // Added height property

  const ShinyButton({
    Key? key,
    required this.child,
    required this.color,
    required this.onTap,
    required this.borderRadius,
    this.width = 150.0, // Default width
    this.height = 50.0, // Default height
  }) : super(key: key);

  @override
  State<ShinyButton> createState() => _ShinyButtonState();
}

class _ShinyButtonState extends State<ShinyButton>
    with SingleTickerProviderStateMixin {
   AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller!.forward(from: 0.0);
      }
    });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          final controllerValue = _controller!.value ?? 0.0;
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Container(
                child: widget.child,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      widget.color,
                      Colors.white,
                      widget.color,
                    ],
                    stops: [
                      0.0,
                      controllerValue,
                      1.1,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
