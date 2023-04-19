import 'dart:io';

import 'package:contentscanner/image_verification/image_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late ImageBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ImageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageBloc, ImageState>(
      listener: (context, state) {
        if (state is ImageVerifiedState) {
          if (state.isNsfw) {
            ScaffoldMessenger.of(context).showSnackBar(
              _snackBar("Image is Inappropriate", color: Colors.red),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              _snackBar("Image is Appropriate", color: Colors.green),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Image Verification'),
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
                  _bloc.add(ImagePickedEvent(File(pickedFile.path)));
                }
              },
              icon: const Icon(
                Icons.image,
              ),
            ),
            const SizedBox(height: 50),
            BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                if (state is ImageLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: state is ImagePickedState
                        ? () async {
                            _bloc.add(VerifyImageEvent());
                          }
                        : null,
                    child: const Text('Verify'),
                  ),
                );
              },
            ),
          ],
        ),
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
