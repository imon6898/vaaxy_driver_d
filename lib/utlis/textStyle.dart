import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//Padding + Margin
const paddingOrMargin20 = EdgeInsets.all(20);
const paddingOrMargin15 = EdgeInsets.all(15);
const size=Size.fromHeight(50.0);

TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.inter( /// use for logo text
      fontSize: 40.sp, fontWeight: FontWeight.w700, ),
  displayMedium: GoogleFonts.inter( /// use for header large and bold text
    fontSize: 30.sp, fontWeight: FontWeight.w700, color: Colors.black,),
  displaySmall: GoogleFonts.inter( /// user for large non-bold text
      fontSize: 22.sp, fontWeight: FontWeight.w700,),
  headlineMedium: GoogleFonts.inter( ///use for normal text
      fontSize: 16.sp, fontWeight: FontWeight.w500, letterSpacing: 0.25,),
  headlineSmall: GoogleFonts.inter(fontSize: 23.sp, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.inter(
      fontSize: 19.sp, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.inter( /// user for light text
      fontSize: 16.sp, fontWeight: FontWeight.w300, color: Colors.black),
  titleSmall: GoogleFonts.inter( /// user for input text
      fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),
  bodyLarge: GoogleFonts.inter(
      fontSize: 15.sp, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.inter(
      fontSize: 13.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: const Color.fromARGB(255, 19, 143, 120),
    backgroundColor: const Color.fromARGB(255, 19, 143, 120),
  ),
  bodySmall:GoogleFonts.inter(
      fontSize: 14.sp, fontWeight: FontWeight.w300, letterSpacing: 0.25,),
 /* caption: GoogleFonts.inter(
      fontSize: 12.sp, fontWeight: FontWeight.w400, letterSpacing: 0.4),*/
  labelSmall: GoogleFonts.inter(
      fontSize: 10.sp, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ButtonStyle btnStyle(Color txtColor, Color bgColor ) {
  return ButtonStyle(
      foregroundColor:MaterialStateProperty.all(txtColor) ,
      backgroundColor:MaterialStateProperty.all(bgColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),

          )
      )
  );
}