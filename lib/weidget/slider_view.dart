import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vaaxy_driver/utlis/color_const.dart';
import 'package:vaaxy_driver/weidget/custom_text_view_light_color_line.dart';

Widget sliderView({
  bool showTitleText = true,
  required List<String> sliderImageList,
  required int sliderIndex,
  required Function(int index) onPageChanged,
  bool autoPlay = true,
  bool fullWidthImage = false,
}) {
  return Column(
    children: [
      if (showTitleText)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextViewLightColorLine(
              text: "Popular offers",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: ColorConst.BLACK_COLOR,
              ),
            ),
            Row(
              children: [
                CustomTextViewLightColorLine(
                  text: "See all",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConst.BLUE_COLOR,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorConst.BLUE_COLOR,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      SizedBox(height: 10.sp),
      Expanded(
        child: CarouselSlider(
          items: sliderImageList.map((e) {
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              color: Colors.green,
              child: Image.asset(
                e,
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 300,
            viewportFraction: fullWidthImage ? 1 : 0.8,
            enableInfiniteScroll: true,
            autoPlay: autoPlay,
            onPageChanged: (index, reason) => onPageChanged(index),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
        ),
      ),
      SizedBox(
        height: 20.sp,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(sliderImageList.length, (index) {
              bool isCurrentIndex = sliderIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 5,
                width: isCurrentIndex ? 15 : 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ),
      ),
    ],
  );
}
