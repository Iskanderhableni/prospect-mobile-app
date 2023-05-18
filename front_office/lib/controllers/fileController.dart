import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import '../models/file_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FileController extends GetxController {
  Rx<List<FileModel>> files = Rx<List<FileModel>>([]);
  final isLoading = false.obs;
  String url = 'http://192.168.156.167:80/api/';
  final box = GetStorage();

  @override
  void onInit() {
    getAllFiles();
    super.onInit();
  }

  Future getAllFiles() async {
    try {
      files.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}getfiles'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['files'];
        for (var item in content) {
          files.value.add(FileModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  /*Future createFile({required String file, title, note}) async {
    try {
      var data = {
        //data is a variable holding an object {'content': content}
        'file': file,
        'title': title,
        'note': note,
      };
      var response = await http.post(Uri.parse('${url}file-upload'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);
      if (response == 201) {
        print(json.decode(response.body));
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }*/

  /*Future createFile({
    required String filePath,
    String title = '',
    String note = '',
  }) async {
    try {
      File file = File(filePath);
      String fileName = file.path.split('/').last;
      String? fileExtension = lookupMimeType(fileName);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${url}file-upload'),
      );
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      request.fields['title'] = title;
      request.fields['note'] = note;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(fileExtension!),
      ));

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }*/
  Future<FileModel?> createFile({
    required String filePath,
    String title = '',
    String note = '',
  }) async {
    try {
      File file = File(filePath);
      String fileName = file.path.split('/').last;
      String? fileExtension = lookupMimeType(fileName);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${url}file-upload'),
      );
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${box.read('token')}';
      request.fields['title'] = title;
      request.fields['note'] = note;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(fileExtension!),
      ));

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        FileModel createdFile = FileModel.fromJson(responseData);
        print(responseData);
        return createdFile;
      } else {
        print(json.decode(response.body));
        return null; // Return null to indicate failure
      }
    } catch (e) {
      print(e.toString());
      return null; // Return null to indicate failure
    }
  }

  /*Future destroy(int id) async {
    try {
      isLoading.value = true;
      var response = await http
          .delete(Uri.parse('${url}file-upload/destroy/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        files.value.removeWhere((file) => file.id == id);
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
*/
  Future<void> destroy(int? id, Function() updateStateCallback) async {
    try {
      isLoading.value = true;
      if (id != null) {
        var response = await http.delete(
          Uri.parse('${url}file-upload/destroy/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
        );
        if (response.statusCode == 200) {
          isLoading.value = false;
          updateStateCallback(); // Call the callback function to update the state
        } else {
          isLoading.value = false;
          print(json.decode(response.body));
        }
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
