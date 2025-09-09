import 'dart:io';
import 'package:file_picker/file_picker.dart'
    show FilePickerResult, FilePicker, FileType;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

Future<File?> pickImageFile() async {
  try {
    // Lets the user pick one file; files with any file extension can be selected
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    // The result will be null, if the user aborted the dialog
    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;
      if (platformFile.path != null) {
        File file = File(platformFile.path!);
        return file;
      }
    }
    return null;
  } catch (e) {
    // Handle specific platform exceptions
    if (e.toString().contains('multiple_request')) {
      throw Exception(
          'File picker is already in use. Please wait and try again.');
    }
    if (e.toString().contains('User cancelled') ||
        e.toString().contains('User canceled')) {
      // User cancelled, return null without throwing
      return null;
    }
    rethrow;
  }
}

Future<File?> pickAudioFile() async {
  try {
    FilePickerResult? result;

    // iOS has issues with FileType.audio, so we use custom extensions instead
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'mp3',
          'wav',
          'flac',
          'aac',
          'm4a',
          'ogg',
          'wma',
          'aiff',
          'au',
          'ra'
        ],
        allowMultiple: false,
      );
    } else {
      // Use FileType.audio for Android and other platforms
      result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );
    }

    // The result will be null, if the user aborted the dialog
    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;
      if (platformFile.path != null) {
        File file = File(platformFile.path!);
        return file;
      }
    }
    return null;
  } catch (e) {
    // Handle specific platform exceptions
    if (e.toString().contains('multiple_request')) {
      throw Exception(
          'File picker is already in use. Please wait and try again.');
    }
    if (e.toString().contains('User cancelled') ||
        e.toString().contains('User canceled')) {
      // User cancelled, return null without throwing
      return null;
    }
    rethrow;
  }
}
