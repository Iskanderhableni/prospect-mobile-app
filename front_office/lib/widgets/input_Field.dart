// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final String? icon;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? visible;
  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.icon,
    this.controller,
    this.widget,
    this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        if (icon != null) Image.asset(icon!),
                        SizedBox(width: icon != null ? 10 : 0),
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0067A4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 19),
                  padding: const EdgeInsets.only(left: 27),
                  width: 755,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: visible == true,
                          autofocus: false,
                          controller: controller,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF002E40),
                                ),
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      widget == null ? Container() : Container(child: widget)
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
