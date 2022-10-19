import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
class SnackBarWidgets{
  static SnackBar SnackBarWidget(String title, String desc, ContentType type) {
  return SnackBar(
    elevation: 0,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: desc,
      contentType: type,
    ),
  );
}
}