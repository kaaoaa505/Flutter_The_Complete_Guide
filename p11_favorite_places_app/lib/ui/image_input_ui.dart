import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputUI extends StatefulWidget {
  const ImageInputUI({super.key});

  @override
  State<ImageInputUI> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInputUI> {
  File? _selectedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageContent = TextButton.icon(
      onPressed: _takePicture,
      label: const Text('Take a picture'),
      icon: const Icon(Icons.camera),
    );

    if (_selectedImage != null) {
      imageContent = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 250,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(50),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: imageContent,
    );
  }
}
