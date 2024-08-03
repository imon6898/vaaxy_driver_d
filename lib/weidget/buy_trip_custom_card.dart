import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String vehicleType;
  final String reminderDay;
  final String tripPass;
  final String bonus;
  final String price;
  final String validity;
  final String discountPercent;
  final String discountPrice;
  final Function() onPressed;

  const CustomCard({
    Key? key,
    required this.vehicleType,
    required this.reminderDay,
    required this.tripPass,
    required this.bonus,
    required this.price,
    required this.validity,
    required this.discountPercent,
    required this.discountPrice,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186,
      child: Card(
        color: Colors.white,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Color(0xFFE8E8E8),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    vehicleType,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      height: 1.33,
                      color: Color(0xFF4D4D4F),
                    ),
                  ),
                  Text(
                    reminderDay,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      height: 1.33,
                      color: Color(0xFFF04935),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 227.0,
                        height: 24.0,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: tripPass,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  height: 1.5,
                                  color: Color(0xFF151414),
                                ),
                              ),
                              TextSpan(
                                text: " $bonus",
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  height: 1.5,
                                  color: Color(0xFF48A43F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          height: 1.5,
                          color: Color(0xFF151414),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        validity,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          height: 1.33,
                          color: Color(0xFF4D4D4F),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${discountPercent} ",
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                height: 1.33,
                                color: Color(0xFF4D4D4F),
                              ),
                            ),
                            TextSpan(
                              text: discountPrice,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                height: 1.33,
                                color: Color(0xFF4D4D4F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff164194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 24),
                  ),
                  child: const Text(
                    'Buy now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
