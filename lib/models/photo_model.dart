// To parse this JSON data, do
//
//     final photoModel = photoModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

PhotoModel photoModelFromJson(String str) => PhotoModel.fromJson(json.decode(str));

String photoModelToJson(PhotoModel data) => json.encode(data.toJson());

class PhotoModel {
  final int? totalResults;
  final int? page;
  final int? perPage;
  final List<Photo>? photos;
  final String? nextPage;

  PhotoModel({
    this.totalResults,
    this.page,
    this.perPage,
    this.photos,
    this.nextPage,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        totalResults: json["total_results"],
        page: json["page"],
        perPage: json["per_page"],
        photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        nextPage: json["next_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_results": totalResults,
        "page": page,
        "per_page": perPage,
        "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "next_page": nextPage,
      };
}

class Photo {
  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final Src? src;
  final bool? liked;
  final String? alt;

  Photo({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        avgColor: json["avg_color"],
        src: json["src"] == null ? null : Src.fromJson(json["src"]),
        liked: json["liked"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src?.toJson(),
        "liked": liked,
        "alt": alt,
      };
}

class Src {
  final String? original;
  final String? large2X;
  final String? large;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? landscape;
  final String? tiny;

  Src({
    this.original,
    this.large2X,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  factory Src.fromJson(Map<String, dynamic> json) => Src(
        original: json["original"],
        large2X: json["large2x"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        portrait: json["portrait"],
        landscape: json["landscape"],
        tiny: json["tiny"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "large2x": large2X,
        "large": large,
        "medium": medium,
        "small": small,
        "portrait": portrait,
        "landscape": landscape,
        "tiny": tiny,
      };
}

class PhotosModel {
  String imgSrc;
  String PhotoName;

  PhotosModel({required this.PhotoName, required this.imgSrc});

  static PhotosModel fromAPI2App(Map<String, dynamic> photoMap) {
    return PhotosModel(PhotoName: photoMap["photographer"], imgSrc: (photoMap["src"])["portrait"]);
  }
}
