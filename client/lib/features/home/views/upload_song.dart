import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/file_picker.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();
  Color selectedColor = Colors.red;
  File? songFile;
  File? thumbnailFile;

  void selectSong() async {
    final file = await pickAudioFile();
    if (file != null) {
      setState(() {
        songFile = file;
      });
    }
  }

  void selectThumbnail() async {
    final file = await pickImageFile();
    if (file != null) {
      setState(() {
        thumbnailFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_as),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: selectThumbnail,
              child: thumbnailFile != null
                  ? SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.file(
                          thumbnailFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        dashPattern: [10, 3],
                        strokeWidth: 2,
                        radius: Radius.circular(16),
                        color: Pallete.borderColor,
                      ),
                      child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open,
                                  size: 40, color: Pallete.greyColor),
                              SizedBox(height: 15),
                              Text(
                                'Select the thumnail for your song',
                                style: TextStyle(color: Pallete.greyColor),
                              ),
                            ],
                          )),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const SizedBox(height: 10),
              CustomField(
                hintText: 'Pick Song',
                controller: _songController,
                readOnly: true,
                onTab: () {
                  // TODO: Implement song pick
                },
              ),
              const SizedBox(height: 20),
              CustomField(
                hintText: 'Artist',
                controller: _artistController,
              ),
              const SizedBox(height: 20),
              CustomField(
                  hintText: 'Song Name', controller: _songNameController),
              ColorPicker(
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                color: selectedColor,
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
                heading: const Text('Select Color'),
              ),
            ]),
          ),
        ],
      )),
    );
  }
}
