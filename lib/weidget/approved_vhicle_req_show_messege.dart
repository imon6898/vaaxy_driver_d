import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApprovedVhicleReqShowMessege extends StatelessWidget {
  final VoidCallback onClosePressed;


  const ApprovedVhicleReqShowMessege({
    Key? key,
    required this.onClosePressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 210,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SvgPicture.asset(
                      'assets/svg/error_icon.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/cross_icon.svg',
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Approved vehicle required",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF151414),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Before accessing the trip pass offer, make sure your vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  height: 1.45,
                  color: Color(0xFF151414),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        onClosePressed();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('is approved'),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF164194),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 20 / 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}