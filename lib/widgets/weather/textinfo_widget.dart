import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class TextInfo extends StatelessWidget {

  final String? label;
  final String? value;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextInfo({
    super.key,
    this.label,
    this.value,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {

    if(label != null){
       return Text(
        '$label: $value',
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
    }
    return Text(
      '$value',
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}