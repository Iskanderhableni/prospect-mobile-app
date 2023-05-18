// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:front_office/controllers/pinController.dart';
import 'package:front_office/models/pin_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PinField extends StatelessWidget {
  PinField({super.key, required this.pin});
  final PinModel pin;
  final TextEditingController _textEditingController = TextEditingController();
  final PinController _pinController = Get.put(PinController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 70),
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFFF7D5D).withOpacity(0.3),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _pinController.destroy(pin.id!);
                },
                icon: const Icon(Icons.cancel_outlined),
                color: const Color(0xFFFF7D5D),
              ),
              Expanded(
                child: Text(
                  pin.content!,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFF7D5D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
