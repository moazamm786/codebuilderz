import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar({required String message, String? title, TextButton? mainButton}) {
  Get.snackbar(
    title ?? 'Alert',
    message,
    snackPosition: SnackPosition.BOTTOM,
    mainButton: mainButton,
    duration: const Duration(seconds: 30),
  );
}
