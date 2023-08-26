import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appTextStyle(double size, Color color, FontWeight fw){
  return GoogleFonts.poppins(color: color, fontSize: size, fontWeight: fw);
}

TextStyle appTextStyleWithHeight(double size, Color color, FontWeight fw,double height){
  return GoogleFonts.poppins(color: color, fontSize: size, fontWeight: fw, height: height);
}