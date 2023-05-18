// ignore_for_file: prefer_const_constructors, unused_field, unused_import

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_office/controllers/fileController.dart';
import 'package:front_office/models/file_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FileField extends StatelessWidget {
  FileField({super.key, required this.file});
  final FileModel file;
  final TextEditingController _textEditingController = TextEditingController();
  final FileController _fileController = Get.put(FileController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 21, left: 90),
      child: Row(
        children: [
          Image.asset('assets/folder.png'),
          Container(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                "Registre de commerce.PDF",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF002E40)),
              )),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 133),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "+ Ajouter une note",
                      style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 90, 194, 227),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Modifier",
                      style: GoogleFonts.poppins(
                        color: Color(0xFFFF7D5D),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Supprimer",
                      style: GoogleFonts.poppins(color: Color(0xFFFF7D5D)),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
