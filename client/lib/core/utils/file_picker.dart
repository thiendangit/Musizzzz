import 'dart:io';
import 'package:file_picker/file_picker.dart'
    show FilePickerResult, FilePicker, FileType;
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

Future<File?> pickImageFile() async {
  try {
    // Lets the user pick one file; files with any file extension can be selected
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

// The result will be null, if the user aborted the dialog
    if (result != null) {
      File file = File(result.files.first.xFile.path);
      return file;
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickAudioFile() async {
  try {
    // Lets the user pick one file; files with any file extension can be selected
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

// The result will be null, if the user aborted the dialog
    if (result != null) {
      File file = File(result.files.first.xFile.path);
      return file;
    }
    return null;
  } catch (e) {
    return null;
  }
}
