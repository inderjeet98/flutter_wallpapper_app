import 'dart:developer';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../models/categoryModel.dart';
import '../full_view_img/full_view_img.dart';

import '../../../controller/services.dart';
import '../../../models/photo_model.dart';

import '../../../widgets/cat_bloack.dart';
import '../../../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotoModel> photosList = [];
  List<CategoryModel> catList = [];
  List catNames = ["Cars", "Nature", "Bikes", "Street", "City", "Flowers"];
  Future? apiCall, catBlockApiCall;
  bool enable = true, catEnable = true;

  @override
  void initState() {
    super.initState();
    catBlockApiCall = getCatBlockData();
    apiCall = getData();
  }

  Future getData() async {
    photosList = await Services().getTrendingWallpaper();
    setState(() => enable = false);
    return photosList;
  }

  Future getCatBlockData() async {
    catList = await Services.getCategoriesList();
    setState(() => catEnable = false);
    return catList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Searchbar(),
            FutureBuilder(
                future: catBlockApiCall,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: catList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    Padding(padding: const EdgeInsets.all(8.0), child: CatBlock(imgSrc: catList[index].catImgUrl, catName: catList[index].catName)))));
                  } else {
                    return Skeletonizer(
                        enabled: catEnable,
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: 8,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CatBlock(
                                            imgSrc: "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                            catName: catNames[index]))))));
                  }
                }),
            FutureBuilder(
                future: apiCall,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: GridView.builder(
                            // shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 13, mainAxisSpacing: 10, mainAxisExtent: 400),
                            itemCount: photosList.isEmpty ? 20 : photosList[0].photos!.length,
                            itemBuilder: (context, index) => Hero(
                                tag: photosList.isEmpty
                                    ? "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                                    : photosList[0].photos![index].src!.original!,
                                child: Container(
                                    decoration: BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(18)),
                                    height: 500,
                                    width: 50,
                                    child: InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => FullViewImg(
                                                    imgUrl: photosList.isEmpty
                                                        ? "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                                                        : photosList[0].photos![index].src!.original!))),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(18),
                                            child: Image.network(
                                                fit: BoxFit.cover,
                                                photosList.isEmpty
                                                    ? "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                                                    : photosList[0].photos![index].src!.original ??
                                                        "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")))))));
                  } else {
                    return Skeletonizer(
                        enabled: catEnable,
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: GridView.builder(
                                // shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 13, mainAxisSpacing: 10, mainAxisExtent: 400),
                                itemCount: photosList.isEmpty ? 20 : photosList[0].photos!.length,
                                itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(18)),
                                    height: 500,
                                    width: 50,
                                    child: InkWell(
                                        onTap: () {},
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(18),
                                            child: Image.network(
                                                fit: BoxFit.cover,
                                                "https://images.pexels.com/photos/3264504/pexels-photo-3264504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")))))));
                  }
                })
          ],
        ),
      ),
    );
  }
}
