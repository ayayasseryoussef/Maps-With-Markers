// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import '../controllers/location_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController(), permanent: true);
  }
}
