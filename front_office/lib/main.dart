// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:front_office/controllers/localisation.dart';
import 'package:front_office/home_screen.dart';
import 'package:front_office/pages/prospect.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:front_office/login_screen.dart';
import 'package:timezone/tzdata.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'notification/notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var token = box.read('token');
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: token == null ? const LoginScreen() : const ProspectScreen());
    // home: token == null ? const LoginScreen() : FileUploadScreen());
  }
}

/*import 'package:slack_notifier/slack_notifier.dart';

void main() {
  final slack =
      SlackNotifier('T057EPD1R26/B057BR03A9K/xRYuZnUD53Rumm3ZEfVzaoF8');
  slack.send(
    'message',
    channel: 'general',
  );
}*/



/*
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(FileUploadApp());
}

class FileUploadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FileUploadScreen(),
    );
  }
}

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  final TextEditingController _titleController = TextEditingController();

  late File _file = File('');
  String _note = '';

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  void _uploadFile() async {
    if (_file == null) {
      return;
    }

    final url = Uri.parse('http://192.168.156.167:80/api/file-upload');
    final request = http.MultipartRequest('POST', url);

    request.fields['title'] = _titleController.text;
    request.fields['note'] = _note;

    final fileStream = http.ByteStream(_file.openRead());
    final fileLength = await _file.length();

    final filePart = http.MultipartFile(
      'file',
      fileStream,
      fileLength,
      filename: _file.path.split('/').last,
    );

    request.files.add(filePart);

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseBody);
        print(responseJson['message']);
        // Handle success
      } else {
        print(
            'Upload failed with status ${response.statusCode}: $responseBody');
        // Handle error
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload File')),
      body: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          ElevatedButton(
            onPressed: _pickFile,
            child: Text('Pick File'),
          ),
          if (_file != null) Text(_file.path),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _note = value;
              });
            },
            maxLines: null,
            decoration: InputDecoration(labelText: 'Note'),
          ),
          ElevatedButton(
            onPressed: _uploadFile,
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }
}
*/