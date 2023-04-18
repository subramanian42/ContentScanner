import 'dart:io';

import 'package:contentscanner/image_screening/image_screening_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../.env.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? _image;
  late ImageScreeningProvider provider;
  @override
  void initState() {
    super.initState();
    provider = ImageScreeningProvider(api_key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Image Screening'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 100,
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _image = File(pickedFile.path);
                });
              }
            },
            icon: const Icon(
              Icons.image,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              onPressed: _image != null
                  ? () async {
                      if (_image != null) {
                        bool isNsfw = await provider.verifyImage(_image!);
                        if (isNsfw) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            _snackBar("Image is Inappropriate",
                                color: Colors.red),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            _snackBar("Image is Appropriate",
                                color: Colors.green),
                          );
                        }
                      }
                    }
                  : null,
              child: const Text('Verify'),
            ),
          ),
        ],
      ),
    );
  }

  SnackBar _snackBar(String text, {required Color color}) {
    return SnackBar(
      content: Text(text),
      backgroundColor: color,
    );
  }
}
