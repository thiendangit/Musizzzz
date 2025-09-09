import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils/file_picker.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:client/features/home/widgets/audio_wave.dart';
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
  bool _isSelectingSong = false;
  bool _isSelectingThumbnail = false;

  void selectSong() async {
    if (_isSelectingSong || _isSelectingThumbnail)
      return; // Prevent multiple requests

    setState(() {
      _isSelectingSong = true;
    });

    try {
      final file = await pickAudioFile();
      if (file != null) {
        setState(() {
          songFile = file;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting song: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSelectingSong = false;
        });
      }
    }
  }

  void selectThumbnail() async {
    if (_isSelectingSong || _isSelectingThumbnail)
      return; // Prevent multiple requests

    setState(() {
      _isSelectingThumbnail = true;
    });

    try {
      final file = await pickImageFile();
      if (file != null) {
        setState(() {
          thumbnailFile = file;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting thumbnail: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSelectingThumbnail = false;
        });
      }
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
              onTap: _isSelectingThumbnail ? null : selectThumbnail,
              child: thumbnailFile != null
                  ? SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          thumbnailFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : DottedBorder(
                      options: const RoundedRectDottedBorderOptions(
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
                              _isSelectingThumbnail
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.folder_open,
                                      size: 40, color: Pallete.greyColor),
                              const SizedBox(height: 15),
                              Text(
                                _isSelectingThumbnail
                                    ? 'Selecting thumbnail...'
                                    : 'Select the thumbnail for your song',
                                style:
                                    const TextStyle(color: Pallete.greyColor),
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
              songFile != null
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.borderColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AudioWave(audioPath: songFile!.path),
                    )
                  : CustomField(
                      hintText:
                          _isSelectingSong ? 'Selecting song...' : 'Pick Song',
                      controller: _songController,
                      readOnly: true,
                      onTab: _isSelectingSong ? null : selectSong,
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
