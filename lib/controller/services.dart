import 'dart:math';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/categoryModel.dart';
import '../models/photo_model.dart';

class Services {
  Map<String, String> headers = {"Authorization": "sFFb36PbRDOlX0EnLRD7q8COoSKwXhKiNJdHL8ezAsc1RZQXb711WjiY"};
  getTrendingWallpaper() async {
    var url = 'https://api.pexels.com/v1/curated';
    List<PhotoModel> photosList = [];

    await http.get(Uri.parse(url), headers: headers).then((value) {
      var jsonData = jsonDecode(value.body);
      // for (Map<String, dynamic> indxe in jsonData) {
      photosList.add(PhotoModel.fromJson(jsonData));
      // }
    });
    return photosList;
  }

  searchWallpapers(String qry) async {
    var url = 'https://api.pexels.com/v1/search?query=$qry&per_page=30';
    List<PhotoModel> photosList = [];

    await http.get(Uri.parse(url), headers: headers).then((value) {
      var jsonData = jsonDecode(value.body);
      // for (Map<String, dynamic> indxe in jsonData) {
      photosList.add(PhotoModel.fromJson(jsonData));
      // }
    });
    return photosList;
  }

  static Future<List<PhotosModel>> searchWallpapers2(String query) async {
    List<PhotosModel> searchWallpapersList = [];
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": "sFFb36PbRDOlX0EnLRD7q8COoSKwXhKiNJdHL8ezAsc1RZQXb711WjiY"}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(PhotosModel.fromAPI2App(element));
      });
    });

    return searchWallpapersList;
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List cateogryName = ["Cars", "Nature", "Bikes", "Street", "City", "Flowers"];
    List<CategoryModel> cateogryModelList = [];
    cateogryModelList.clear();
    for (int i = 0; i < cateogryName.length; i++) {
      final random = Random();

      PhotosModel photoModel = (await searchWallpapers2(cateogryName[i]))[0 + random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList.add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: cateogryName[i]));
    }

    return cateogryModelList;
  }
}
