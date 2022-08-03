import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/sizeConfig.dart';

const textcolor323B4B = Color(0xff323B4B);

double calculateSize(double size) {
  var val = size / 8.53;
  return val * SizeConfig.heightMultiplier!;
}

final pageMargin = EdgeInsets.only(
  left: calculateSize(28),
  right: calculateSize(28),
  top: calculateSize(20),
);

Widget appText(String tx, double size,
    {FontWeight weight = FontWeight.w400,
    topmargin = 0.0,
    bottommargin = 0.0,
    leftmargin = 0.0,
    rightmargin = 0.0,
    TextAlign align = TextAlign.center,
    Color color = Colors.black,
    double? space,
    bool softwrap = true,
    TextOverflow? overflow,
    TextDecoration? decoration,
    int? maxlines,
    FontStyle fontStyle = FontStyle.normal}) {
  return Container(
    margin: EdgeInsets.only(
        top: calculateSize(topmargin),
        bottom: calculateSize(bottommargin),
        left: calculateSize(leftmargin),
        right: calculateSize(rightmargin)),
    child: Text(
      tx == null ? "" : tx,
      softWrap: softwrap,
      overflow: overflow,
      maxLines: maxlines,
      textAlign: align,
      style: TextStyle(
        decoration: decoration,
        fontSize: calculateSize(size),
        fontWeight: weight,
        fontStyle: fontStyle,
        color: color,
        letterSpacing: space,
      ),
    ),
  );
}

class SearchWidget extends StatelessWidget {
  final trailingButton;
  final prefixicon;
  final controller;
  final labeltext;

  SearchWidget(
      {this.trailingButton, this.prefixicon, this.controller, this.labeltext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
        calculateSize(12),
      )),
      //margin: EdgeInsets.symmetric(horizontal: calculatefontSize(5)),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.done,
        style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: calculateSize(17),
            color: Color(0xff04030F)),
        decoration: InputDecoration(
          fillColor: Color(0xffFAFBFC),
          filled: true,
          label: labeltext,
          labelStyle: TextStyle(color: Color(0xff319992)),
          suffixIcon: trailingButton,
          prefixIcon: prefixicon,
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(calculateSize(6))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(calculateSize(6))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(calculateSize(6))),
        ),
      ),
    );
  }
}
