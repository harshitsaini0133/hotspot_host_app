import 'dart:convert';

class GetExperienceData {
  final String? message;
  final Data? data;

  GetExperienceData({this.message, this.data});

  factory GetExperienceData.fromJson(String str) =>
      GetExperienceData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetExperienceData.fromMap(Map<String, dynamic> json) =>
      GetExperienceData(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"message": message, "data": data?.toMap()};
}

class Data {
  final List<Experience>? experiences;

  Data({this.experiences});

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    experiences: json["experiences"] == null
        ? []
        : List<Experience>.from(
            json["experiences"]!.map((x) => Experience.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "experiences": experiences == null
        ? []
        : List<dynamic>.from(experiences!.map((x) => x.toMap())),
  };
}

class Experience {
  final int? id;
  final String? name;
  final String? tagline;
  final String? description;
  final String? imageUrl;
  final String? iconUrl;
  final int? order;

  Experience({
    this.id,
    this.name,
    this.tagline,
    this.description,
    this.imageUrl,
    this.iconUrl,
    this.order,
  });

  factory Experience.fromJson(String str) =>
      Experience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
    id: json["id"],
    name: json["name"],
    tagline: json["tagline"],
    description: json["description"],
    imageUrl: json["image_url"],
    iconUrl: json["icon_url"],
    order: json["order"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "tagline": tagline,
    "description": description,
    "image_url": imageUrl,
    "icon_url": iconUrl,
    "order": order,
  };
}
