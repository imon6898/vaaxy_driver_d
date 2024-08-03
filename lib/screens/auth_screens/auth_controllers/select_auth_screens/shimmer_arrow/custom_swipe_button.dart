import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomSwipButton extends StatefulWidget {
  const CustomSwipButton({Key? key}) : super(key: key);

  @override
  State<CustomSwipButton> createState() => _CustomSwipButtonState();
}

class _CustomSwipButtonState extends State<CustomSwipButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Adjust duration as needed
    );

    _animation = Tween<Offset>(
      begin: Offset(10, 10),
      end: Offset(10, 0), // Adjust the amount of vertical movement
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true); // Animation repeats with reverse
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value,
          child: child,
        );
      },
      child: Container(

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,

        ),
        child: Shimmer.fromColors(
          baseColor: Colors.black!,
          highlightColor: Colors.grey[100]!,
          child: Image.asset(
            'assets/image/app_deverse_logo.png', // Replace with your image file
            width: 220,
            height: 220,
            fit: BoxFit.cover, // Set BoxFit property
          ),
        ),
      ),
    );
  }
}
