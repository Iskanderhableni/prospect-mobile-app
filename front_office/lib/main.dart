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

