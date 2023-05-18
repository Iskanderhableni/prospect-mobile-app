// ignore_for_file: file_names, unrelated_type_equality_checks

/*import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/pin_model.dart';

class PinController extends GetxController {
  Rx<List<PinModel>> pins = Rx<List<PinModel>>([]);
  final box = GetStorage();
  final isLoading = false.obs;

  String url = 'http://192.168.219.167:80/api/pins';
  @override
  void onInit() {
    getAllPins();
    super.onInit();
  }

  Future getAllPins() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('http://192.168.219.167:80/api/pins'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        for (var item in json.decode(response.body)['pins']) {
          pins.value.add(PinModel.fromJson(item));
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
}*/
import 'dart:convert';
import '../models/pin_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PinController extends GetxController {
  Rx<List<PinModel>> pins = Rx<List<PinModel>>([]);
  final isLoading = false.obs;
  String url = '192.168.156.167:80/api/';

  final box = GetStorage();

  @override
  void onInit() {
    getAllPins();
    super.onInit();
  }

  Future getAllPins() async {
    try {
      pins.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}pins'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['pins'];
        for (var item in content) {
          pins.value.add(PinModel.fromJson(item));
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

  /*Future createPost({
    required String content,
  }) async {
    try {
      var data = {
        'content': content,
      };

      var response = await http.post(
        Uri.parse('${url}pins/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }*/

  Future createpin({required String content}) async {
    try {
      var data = {
        //data is a variable holding an object {'content': content}
        'content': content,
      };
      var response = await http.post(Uri.parse('${url}pins/store'),
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
  }

  Future destroy(int id) async {
    try {
      isLoading.value = true;
      var response =
          await http.delete(Uri.parse('${url}pins/destroy/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        pins.value.removeWhere((pin) => pin.id == id);
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
