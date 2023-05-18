// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_null_comparison, depend_on_referenced_packages
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:front_office/controllers/pinController.dart';
import 'package:front_office/controllers/fileController.dart';
import 'package:front_office/main.dart';
import 'package:front_office/models/file_model.dart';
import 'package:front_office/widgets/pin_field.dart';
import 'package:front_office/widgets/input_Field.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:mailer/mailer.dart';
import 'package:path/path.dart' as path;
import 'package:mailer/smtp_server.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:slack_notifier/slack_notifier.dart';
import '../controllers/localisation.dart';
import '../notification/notification.dart';

late DateTime scheduleTime;
String hint = '';
DateTime _selectedDate = DateTime.now();
TimeOfDay _timeday = TimeOfDay(hour: 9, minute: 0);
Duration _duration = Duration(hours: 0);
bool _showInputField = false;
String localisation = "Choisir la localisation...";
String file_name = 'fichier.pdf';
int? fileId;
final TextEditingController _textEditingController = TextEditingController();
final TextEditingController _controller = TextEditingController();
final TextEditingController _testcontroller = TextEditingController();
// ignore: non_constant_identifier_names
final TextEditingController reminder_controller = TextEditingController();
final PinController _pinController = Get.put(PinController());
final FileController _fileController = Get.put(FileController());
final toMailController = TextEditingController();

bool _value_slack = false;
bool _value_mail = false;

class ProspectScreen extends StatefulWidget {
  const ProspectScreen({super.key});

  @override
  State<ProspectScreen> createState() => ProspectScreenState();
}

class ProspectScreenState extends State<ProspectScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    scheduleTime = DateTime.now();
    hint = DateFormat('dd-MM hh:mm a').format(scheduleTime);
  }

  @override
  Widget build(BuildContext context) {
    //  final box = GetStorage();
    // var token = box.read('token');
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 1920,
          height: 1080,
          color: Color.fromARGB(255, 255, 254, 254),
          child: Stack(
            children: [
              Positioned(
                left: 184,
                top: 151,
                child: Text(
                  "Rapport De Prospection N° Xxxxxx",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color(0xFF002E40),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 182,
                top: 217,
                child: SizedBox(
                  width: 885,
                  height: 827,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 65),
                            child: MyInputField(
                              title: "Titre",
                              hint: "Exp : Signature du contrat ",
                              controller: _testcontroller,
                              widget: Container(
                                width: 216,
                                height: 31,
                                margin: EdgeInsets.only(right: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    //SlackNotifierService.sendMessage(
                                    //  _testcontroller.text,
                                    //attachments:List.of(elements));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 90, 194, 227),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Ajouter description ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 90, 194, 227),
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /*MyInputField(
                            title: "Localisation",
                            hint: "24 Rue du Lac Huron 1053 Tunis, Tunisie",
                          ),*/
                          Container(
                            padding: EdgeInsets.only(left: 60, right: 65),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: MyInputField(
                                    title: "Jour",
                                    visible: true,
                                    hint: DateFormat(
                                      'd MMMM y',
                                      'fr_FR', // Add the French locale
                                    ).format(_selectedDate),
                                    widget: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _getDataFromUser();
                                        },
                                        icon: Image.asset(
                                          'assets/vuesax-linear-menu-board.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 35),
                                SizedBox(
                                  width: 160,
                                  child: MyInputField(
                                    title: "Heure",
                                    visible: true,
                                    hint: _timeday.format(context).toString(),
                                    widget: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _getTimeFromUser();
                                        },
                                        icon: Image.asset(
                                          'assets/vuesax-linear-menu-board.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                SizedBox(
                                  width: 161,
                                  child: MyInputField(
                                    title: "Durée",
                                    visible: true,
                                    hint: _duration != null
                                        ? '${'${_duration.inHours.toString().padLeft(2, '0')}h'}:${'${(_duration.inMinutes.remainder(60)).toString().padLeft(2, '0')}m'}'
                                        : '',
                                    widget: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _getDurationFromUser();
                                        },
                                        icon: Image.asset(
                                          'assets/ic_query_builder_24px.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 65, top: 37),
                                    child: Text(
                                      'Localisation',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xFF0067A4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 60, top: 20, right: 65),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset(
                                              "assets/localisation.png"),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _controller,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: localisation,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 15,
                                              ),
                                              hintStyle: GoogleFonts.poppins(
                                                color: Color(0xFF002E40),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          width: 216,
                                          height: 31,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              ShowModal(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 90, 194, 227),
                                                  width: 0.5,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              "Modifier la localisation ",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 90, 194, 227),
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 37, left: 43, right: 43),
                                child: Positioned(
                                  child: DottedLine(
                                    dashColor: Color(0xFFDBDDE6),
                                    lineThickness: 1.5,
                                    dashGapLength: 10,
                                    dashLength: 15,
                                  ),
                                ),
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 65, top: 37),
                                        child: Text(
                                          "Attacher des pièces jointes",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF002E40)),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 21, left: 90),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/folder.png'),
                                          Container(
                                            padding: EdgeInsets.only(left: 14),
                                            child: Container(
                                              width: 150,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      file_name,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 133),
                                                child: TextButton(
                                                    onPressed: () async {},
                                                    child: Text(
                                                      "+ Ajouter une note",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Color.fromARGB(
                                                            255, 90, 194, 227),
                                                      ),
                                                    )),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Modifier",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFFFF7D5D),
                                                      ),
                                                    )),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: TextButton(
                                                    onPressed: () {
                                                      if (fileId != null) {
                                                        _fileController.destroy(
                                                            fileId, () {
                                                          setState(() {
                                                            fileId = null;
                                                            file_name =
                                                                "ajouter un fichier";
                                                          });
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      "Supprimer",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Color(
                                                                  0xFFFF7D5D)),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 755,
                                      height: 50,
                                      margin:
                                          EdgeInsets.only(left: 67, top: 20),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFDBDDE6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide.none,
                                            ),
                                          ),
                                          onPressed: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles();
                                            if (result != null) {
                                              File file = File(
                                                  result.files.single.path!);
                                              String filePath = file.path;
                                              String fileName =
                                                  path.basename(filePath);

                                              FileModel? createdFile =
                                                  await _fileController
                                                      .createFile(
                                                filePath: filePath,
                                                title: fileName,
                                                note: "sdsdsd",
                                              );

                                              if (createdFile != null) {
                                                setState(() {
                                                  fileId = createdFile.id;
                                                  file_name = fileName;
                                                });
                                              }
                                            }
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Image.asset(
                                                    "assets/Iconly-Light-Plus.png"),
                                              ),
                                              Text("Ajouter un Fichier",
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0xFF0067A4),
                                                    fontSize: 15,
                                                  ))
                                            ],
                                          )),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 65, top: 25),
                                      child: Text(
                                        "Description",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Color(0xFF002E40),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 88,
                                      margin: EdgeInsets.only(
                                          left: 60, top: 20, right: 65),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 27),
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Commencer à rédiger',
                                                        hintStyle:
                                                            GoogleFonts.poppins(
                                                          color: Color(
                                                                  0xFF002E40)
                                                              .withOpacity(0.5),
                                                          fontSize: 15,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 1120,
                  top: 217,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 430,
                        height: 703,
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(left: 31, top: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Epingler",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Color(0xFF0067A4),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Obx(() {
                                    return _pinController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: _pinController
                                                .pins.value.length,
                                            itemBuilder: (context, index) {
                                              return PinField(
                                                pin: _pinController
                                                    .pins.value[index],
                                              );
                                            },
                                          );
                                  }),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Center(
                                      child:
                                          _showInputField // If _showInputField is true, show the Column with the TextField and IconButton
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center, // Align children vertically at the center
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                _textEditingController,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Enter text',
                                                            ),
                                                          ),
                                                        ),
                                                        Obx(() {
                                                          return _pinController
                                                                  .isLoading
                                                                  .value
                                                              ? CircularProgressIndicator()
                                                              : IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await _pinController
                                                                        .createpin(
                                                                      content: _textEditingController
                                                                          .text
                                                                          .trim(),
                                                                    );
                                                                    _textEditingController
                                                                        .clear();
                                                                    _pinController
                                                                        .getAllPins();
                                                                    setState(
                                                                        () {
                                                                      _showInputField =
                                                                          false;
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .send),
                                                                );
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      height: 40,
                                                      width: 330,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    90,
                                                                    194,
                                                                    227),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: BorderSide
                                                                  .none,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _showInputField =
                                                                  true;
                                                            });
                                                          },
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Image.asset(
                                                                    "assets/send.png"),
                                                              ),
                                                              Text(
                                                                "+ Ajouter",
                                                                style: GoogleFonts.poppins(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: MyInputField(
                                      title: "Ajouter une personne",
                                      hint: "Email",
                                      icon: "assets/add.png",
                                      widget: Container(
                                        width: 105,
                                        height: 31,
                                        margin: EdgeInsets.only(right: 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_value_mail == true) {
                                              sendMail();
                                            } else if (_value_slack == true) {
                                              _slackNotifier();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 90, 194, 227),
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Envoyer",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 90, 194, 227),
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      controller: toMailController,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 405,
                                    height: 113,
                                    margin: EdgeInsets.only(right: 30),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(219, 221, 230, 100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: 0.6,
                                            child: Checkbox(
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      style:
                                                          BorderStyle.solid)),
                                              value: _value_slack,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  _value_slack = newValue!;
                                                  if (_value_slack ==
                                                      newValue) {
                                                    _value_mail = false;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Image.asset('assets/Slack_icon.png'),
                                          SizedBox(width: 3),
                                          Text("Slack",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 0, 103, 164),
                                                  fontSize: 15)),
                                          SizedBox(width: 50),
                                          Transform.scale(
                                            scale: 0.6,
                                            child: Checkbox(
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      style:
                                                          BorderStyle.solid)),
                                              value: _value_mail,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  _value_mail = newValue!;
                                                  if (_value_mail == newValue) {
                                                    _value_slack = false;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Image.asset('assets/Gmail_icon.png'),
                                          SizedBox(width: 3),
                                          Text("Email",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 0, 103, 164),
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: MyInputField(
                                      title: "rappel",
                                      visible: true,
                                      hint: hint,
                                      widget: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xFF0067A4),
                                            size: 24, // Adjust the size here
                                          ),
                                          onPressed: () {
                                            DatePicker.showDateTimePicker(
                                              context,
                                              showTitleActions: true,
                                              locale: LocaleType.fr,
                                              onChanged: (date) {},
                                              onConfirm: (date) {
                                                setState(() {
                                                  scheduleTime = date;
                                                  hint = DateFormat(
                                                          'dd-MM hh:mm a')
                                                      .format(scheduleTime);

                                                  debugPrint(
                                                      'Notification Scheduled for $scheduleTime');
                                                  NotificationService()
                                                      .scheduleNotification(
                                                          title: 'rappel',
                                                          body:
                                                              'vous avez un meeting consultez votre calendrier',
                                                          scheduledNotificationDateTime:
                                                              scheduleTime);
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      controller: reminder_controller,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 356,
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromRGBO(
                                                119, 192, 235, 0.686),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                        onPressed: () async {},
                                        child: Text(
                                          "Enregistrer le rapport",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 103, 164)),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 110,
                    height: 1080,
                    color: Color.fromARGB(255, 255, 254, 254),
                    child: Material(elevation: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDataFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
        print(_selectedDate);
      });
    } else {
      print("error");
    }
  }

  _getDurationFromUser() async {
    Duration? pickDuration = await showDurationPicker(
        context: context, initialTime: Duration(minutes: 0));
    if (pickDuration != null) {
      setState(() {
        _duration = pickDuration;
        print(_duration.inHours.toString().padLeft(2, '0' + 'h') +
            _duration.inMinutes.toString().padLeft(2, '0' + 'm'));
      });
    }
  }

  void _getTimeFromUser() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      //value == selected value
      if (value != null) {
        setState(() {
          _timeday = value;
          print(_timeday.format(context).toString());
        });
      } else {
        print('error');
      }
    });
  }

  // ignore: non_constant_identifier_names
  void ShowModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 600,
          color: Colors.red,
          child: Center(
              child: OpenStreetMapSearchAndPick(
                  center: LatLong(36.8354925, 10.24886719352586),
                  buttonColor: Colors.blue,
                  buttonText: 'Choisir la Localisation',
                  onPicked: (pickedData) {
                    Navigator.pop(context);
                    setState(() {
                      localisation = pickedData.address;
                    });
                  })),
        );
      },
    );
  }

  Future<void> sendMail() async {
    String username = ""; // Your Email
    String password = ""; // Your Email Password

    //Create Gmail Server
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);

    // Create Gmail Message
    final message = Message()
      ..from = Address(username)
      ..recipients.add(toMailController.text);
    //..ccRecipients.addAll(['abc@gmail.com','pqr@gmail.com','...'])
    //..bccRecipients.add('...')
    //..subject = subjectController.text
    //..text = textController.text;

    try {
      final sendReport =
          await send(message, smtpServer).then((value) => clear());
      print('Message Sent:' + sendReport.toString());
    } catch (e) {
      print('Message not sent:' + e.toString());
    }
  }

  clear() {
    toMailController.text = '';
    //subjectController.text = '';
    //textController.text = '';
  }

  void _slackNotifier() {
    final slack =
        SlackNotifier('T....../B....../x......');
    slack.send(
      'message',
      channel: 'general',
    );
  }
}
