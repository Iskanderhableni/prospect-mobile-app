// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

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

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(responseBody);
      print(responseJson['message']);
      // Handle success
    } else {
      print('Upload failed with status ${response.statusCode}: $responseBody');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload file')),
      body: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          ElevatedButton(
            onPressed: _pickFile,
            child: Text('Pick file'),
          ),
          if (_file != null) Text(_file.path),
          TextFormField(
            onChanged: (value) {
              _note = value;
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
