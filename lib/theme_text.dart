import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeText {
  static final headline = GoogleFonts.dosis(
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      fontSize: 36.sp,
    ),
  );

  static final subhead = GoogleFonts.dosis(
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 20.sp,
    ),
  );
}
