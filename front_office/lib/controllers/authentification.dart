// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_office/home_screen.dart';
import 'package:front_office/pages/prospect.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthentificationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  String url = 'http://192.168.156.167:80/api/';

  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };
      final response = await http.post(
        Uri.parse('${url}register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => const ProspectScreen());
      } else {
        isLoading.value = false;
        final message = json.decode(response.body)['message'];
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body)['message']);
      }
    } catch (error) {
      isLoading.value = false;
      print(error.toString());
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final data = {
        'username': username,
        'password': password,
      };
      final response = await http.post(
        Uri.parse('${url}login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.offAll(() => ProspectScreen());
        print(json.encode(json.decode(response.body)));
      } else {
        isLoading.value = false;
        final message = json.decode(response.body)['message'];
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(response.body)['message']);
      }
    } catch (error) {
      isLoading.value = false;
      print(error.toString());
    }
  }
}
