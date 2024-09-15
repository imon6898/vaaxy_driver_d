import 'package:flutter/material.dart';

class CustomSecondaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final VoidCallback? onPressedMarked;
  final String title;

  CustomSecondaryAppbar({
    super.key,
    required this.onPressed,
    this.onPressedMarked,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: onPressed,
        icon: Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xff164194),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}