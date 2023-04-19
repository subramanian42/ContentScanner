import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/image_model.dart';

class ImageScreeningRepository {
  final String apiKey;
  ImageScreeningRepository(this.apiKey);
  Future<bool> verifyImage(File file) async {
    try {
      var url = Uri.parse(
          'https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content-file');

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(
          {
            'content-type': 'multipart/form-data',
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host':
                'nsfw-images-detection-and-classification.p.rapidapi.com'
          },
        )
        ..files.add(
          await http.MultipartFile.fromPath(
            'image',
            file.absolute.path,
          ),
        );

      var response = await request.send();

      var body = await response.stream.bytesToString();

      return ImageModel.fromRawJson(body).unsafe;
    } catch (e) {
      throw ("exception $e has occoured ");
    }
  }
}
