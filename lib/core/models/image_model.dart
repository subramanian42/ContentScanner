import 'dart:convert';

class ImageModel {
  ImageModel({
    required this.unsafe,
    required this.objects,
  });

  bool unsafe;
  List<Object> objects;
  factory ImageModel.fromRawJson(String str) =>
      ImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        unsafe: json["unsafe"],
        objects:
            List<Object>.from(json["objects"].map((x) => Object.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "unsafe": unsafe,
        "objects": List<dynamic>.from(objects.map((x) => x.toJson())),
      };
}

class Object {
  Object({
    required this.box,
    required this.score,
    required this.label,
  });

  List<int> box;
  double score;
  String label;

  factory Object.fromJson(Map<String, dynamic> json) => Object(
        box: List<int>.from(json["box"].map((x) => x)),
        score: json["score"]?.toDouble(),
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "box": List<dynamic>.from(box.map((x) => x)),
        "score": score,
        "label": label,
      };
}
